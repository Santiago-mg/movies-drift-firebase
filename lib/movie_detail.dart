import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/movie_note.dart';
import 'package:movies/repository/movie_note_repository.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final MovieNoteRepository noteRepository;

  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.noteRepository,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final TextEditingController _noteController = TextEditingController();
  MovieNote? savedNote;
  int rating = 0;

  @override
  void initState() {
    super.initState();
    loadNote();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> loadNote() async {
    final saved = await widget.noteRepository.getNoteForMovie(widget.movie.id);
    if (!mounted) return;

    setState(() {
      savedNote = saved;
      rating = saved?.rating ?? 0;
      _noteController.text = saved?.note ?? '';
    });
  }

  Future<void> saveNote() async {
    if (rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Elige una calificación de 1 a 5')),
      );
      return;
    }

    final note = MovieNote(
      movieId: widget.movie.id,
      note: _noteController.text.trim(),
      rating: rating,
      updatedAt: DateTime.now(),
    );

    await widget.noteRepository.saveNote(note);
    await loadNote();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nota guardada')),
    );
  }

  String get syncText {
    final saved = savedNote;
    if (saved == null) return 'No hay nota guardada';
    return saved.pendingSync ? 'Pendiente de sincronizar' : 'Sincronizada';
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Detalle de la película'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Un póster vertical, centrado y con bordes redondeados.
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 260),
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AspectRatio(
                          aspectRatio: 2 / 3,
                          child: Image.asset(
                            widget.movie.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return ColoredBox(
                                color: colors.surfaceContainerHighest,
                                child: Center(
                                  child: Icon(
                                    Icons.movie_outlined,
                                    size: 72,
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                   widget.movie.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Wrap permite que las etiquetas bajen en pantallas pequeñas.
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(
                          Icons.local_movies_outlined,
                          size: 18,
                        ),
                        label: Text(widget.movie.genre),
                        side: BorderSide.none,
                        backgroundColor: colors.secondaryContainer,
                      ),
                      Chip(
                        avatar: Icon(
                          widget.movie.watched
                              ? Icons.check_circle_outline
                              : Icons.schedule,
                          size: 18,
                        ),
                        label: Text(
                          widget.movie.watched ? 'Vista' : 'Pendiente por ver',
                        ),
                        side: BorderSide.none,
                        backgroundColor: colors.surfaceContainerHighest,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Sinopsis',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.movie.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Mi nota',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text('Estado: $syncText'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      for (int i = 1; i <= 5; i++)
                        IconButton(
                          onPressed: () => setState(() => rating = i),
                          icon: Icon(
                            i <= rating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                          ),
                        ),
                    ],
                  ),
                  TextField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Escribe tu nota',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: saveNote,
                      child: const Text('Guardar'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 
  
