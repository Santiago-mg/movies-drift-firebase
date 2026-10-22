import 'package:flutter/material.dart';
import 'package:movies/movie_card.dart';
import 'package:movies/movie_detail.dart';
import 'package:movies/repository/movie_note_repository.dart';
import 'package:movies/services/movie_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/movie.dart';

class MovieScreen extends StatefulWidget {
  final MovieNoteRepository noteRepository;

  const MovieScreen({super.key, required this.noteRepository});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // -----------------------------
  // ESTADO DE LA PANTALLA
  // -----------------------------

  int? favoriteId;

  late final MovieService _service;
  late Future<List<Movie>> _futureMovies;

  // -----------------------------
  // CICLO DE VIDA
  // -----------------------------

  void retryMovieList(){
    setState(() {
      _futureMovies = _service.getMovies();
    });
  }

  Future<void> saveFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (favoriteId == null) {
      await prefs.remove('favoriteId');
    } else {
      await prefs.setInt('favoriteId', favoriteId!);
    }
  }

  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      favoriteId = prefs.getInt('favoriteId');
    });
  }

  @override
  void initState() {
    super.initState();

    // En la version final cargamos automaticamente
    // cuando nace la pantalla.
    //fetchMovies();
    _service = MovieService('https://dummyjson.com/c/9b8d-d4ea-4bc2-8601');
    _futureMovies = _service.getMovies();
    loadFavorite();
  }

  // -----------------------------
  // ESTRUCTURA GENERAL
  // -----------------------------

  void openMovieDetail(Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieDetailPage(
          movie: movie,
          noteRepository: widget.noteRepository,
        ),
      ),
    );
  }

  Future<void> syncNotes() async {
    final repo = widget.noteRepository;
    String message;

    if (!repo.hasRemote) {
      message = 'Firebase no está disponible';
    } else {
      final synced = await repo.syncPending();
      message = synced == 0
          ? 'No se sincronizó ninguna nota (no hay pendientes o falló Firebase)'
          : 'Notas sincronizadas: $synced';
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void toggleFavorite(int movieId) {
    setState(() {
      favoriteId = favoriteId == movieId ? null : movieId;
    });
    saveFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Mis películas'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Sincronizar notas',
            icon: const Icon(Icons.sync),
            onPressed: syncNotes,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  // -----------------------------
  // ESTADO -> INTERFAZ
  // -----------------------------

  Widget _buildBody() {
    return FutureBuilder<List<Movie>>(
      future: _futureMovies,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.cloud_off_outlined, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'No pudimos cargar las películas',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: retryMovieList,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }

        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.movie_outlined, size: 48),
                  SizedBox(height: 16),
                  Text(
                    'Todavía no hay películas disponibles',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          // El encabezado se desplaza junto con las tarjetas.
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tu próxima película',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${movies.length} películas para explorar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Toca una tarjeta para ver más o marca tu favorita con la estrella.',
                    ),
                  ],
                ),
              );
            }
            final movie = movies[index - 1];
            final bool isFavorite = movie.id == favoriteId;

            return MovieCard(
              movie: movie,
              onTap: () {
                openMovieDetail(movie);
              },
              isFavorite: isFavorite,
              onFavoriteTap: () {
                toggleFavorite(movie.id);
              },
            );
          },
        );
      },
    );
  }
}
