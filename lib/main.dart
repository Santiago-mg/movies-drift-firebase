import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies/firebase_options.dart';
import 'package:movies/local/app_database.dart';
import 'package:movies/local/movie_note_local_data_source.dart';
import 'package:movies/remote/movie_note_remote_data_source.dart';
import 'package:movies/repository/movie_note_repository.dart';
import 'movie_screen.dart';

Future<void> main() async {
  // Necesario antes de usar plugins (Firebase, path_provider) en main.
  WidgetsFlutterBinding.ensureInitialized();

  MovieNoteRemoteDataSource? remote;

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    remote = MovieNoteRemoteDataSource(FirebaseFirestore.instance);
  } catch (_) {
    // Si Firebase no inicia, la app sigue funcionando solo con Drift.
  }

  final database = AppDatabase();
  final local = MovieNoteLocalDataSource(database);
  final noteRepository = MovieNoteRepository(local: local, remote: remote);

  runApp(MyApp(noteRepository: noteRepository));
}

class MyApp extends StatelessWidget {
  final MovieNoteRepository noteRepository;

  const MyApp({super.key, required this.noteRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MovieScreen(noteRepository: noteRepository),
    );
  }
}
