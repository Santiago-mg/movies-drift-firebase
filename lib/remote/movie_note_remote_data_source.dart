import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/models/movie_note.dart';

class MovieNoteRemoteDataSource {
  final FirebaseFirestore firestore;

  MovieNoteRemoteDataSource(this.firestore);

  Future<void> upsertNote(MovieNote note) async {
    // El timeout evita quedarse esperando para siempre si no hay internet.
    await firestore
        .collection('movie_notes')
        .doc(note.movieId.toString())
        .set(note.toJson())
        .timeout(const Duration(seconds: 5));
  }
}
