import 'package:movies/local/movie_note_local_data_source.dart';
import 'package:movies/models/movie_note.dart';
import 'package:movies/remote/movie_note_remote_data_source.dart';

class MovieNoteRepository {
  final MovieNoteLocalDataSource local;
  final MovieNoteRemoteDataSource? remote;

  MovieNoteRepository({
    required this.local,
    this.remote,
  });

  bool get hasRemote => remote != null;

  Future<MovieNote?> getNoteForMovie(int movieId) =>
      local.getNoteForMovie(movieId);

  // Primero Drift, despues Firestore.
  Future<void> saveNote(MovieNote note) async {
    await local.saveNote(note);

    final remoteSource = remote;
    if (remoteSource == null) return;

    try {
      await remoteSource.upsertNote(note);
      await local.markSynced(note.movieId);
    } catch (_) {
      // La nota ya quedo local y seguira pendiente.
    }
  }

  // Reintenta solo las notas con pendingSync = true.
  // Devuelve cuantas se pudieron enviar.
  Future<int> syncPending() async {
    final remoteSource = remote;
    if (remoteSource == null) return 0;

    final pending = await local.getPendingNotes();
    int synced = 0;

    for (final note in pending) {
      try {
        await remoteSource.upsertNote(note);
        await local.markSynced(note.movieId);
        synced++;
      } catch (_) {
        // Esa nota queda pendiente para otro intento.
      }
    }

    return synced;
  }
}
