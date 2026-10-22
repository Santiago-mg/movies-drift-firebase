import 'package:drift/drift.dart';
import 'package:movies/local/app_database.dart';
import 'package:movies/models/movie_note.dart';

class MovieNoteLocalDataSource {
  final AppDatabase db;

  MovieNoteLocalDataSource(this.db);

  MovieNote _toDomain(MovieNoteRow row){
    return MovieNote(
      movieId: row.movieId, 
      note: row.note, 
      rating: row.rating, 
      updatedAt: row.updatedAt,
      pendingSync: row.pendingSync
      );
  }

  //recuperar una nota
  Future<MovieNote?> getNoteForMovie(int movieId) async {
    final query = db.select(db.movieNotes)
    ..where((t) => t.movieId.equals(movieId));

    final row = await query.getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  // insertar o actualizar (una sola fila por pelicula)
  Future<void> saveNote(MovieNote note) async {
    await db.into(db.movieNotes).insertOnConflictUpdate(
      MovieNotesCompanion.insert(
        movieId: Value(note.movieId),
        note: note.note,
        rating: note.rating,
        updatedAt: note.updatedAt,
        pendingSync: const Value(true),
      ),
    );
  }

  // notas que todavia no llegan a Firestore
  Future<List<MovieNote>> getPendingNotes() async {
    final rows = await (db.select(db.movieNotes)
          ..where((t) => t.pendingSync.equals(true)))
        .get();

    return rows.map(_toDomain).toList();
  }

  // se llama solo despues de que Firestore respondio bien
  Future<void> markSynced(int movieId) async {
    await (db.update(db.movieNotes)
          ..where((t) => t.movieId.equals(movieId)))
        .write(
      const MovieNotesCompanion(
        pendingSync: Value(false),
      ),
    );
  }
}
