import 'dart:convert';
import 'dart:io';

import 'package:movies/models/movie_note.dart';
import 'package:path_provider/path_provider.dart';

class MovieNoteStorage {
  static const _fileName = 'movie_notes.json';

  // to get the specific file
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<List<MovieNote>> _readAll() async {
    final file = await _getFile();
    if (!await file.exists()) return [];

    final content = await file.readAsString();
    if (content.isEmpty) return [];

    final List<dynamic> data = jsonDecode(content);
    return data.map((item) => MovieNote.fromJson(item)).toList();
  }

  Future<void> _writeAll(List<MovieNote> notes) async {
    final file = await _getFile();
    final jsonString = jsonEncode(notes.map((note) => note.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<MovieNote?> getNoteForMovie(int movieId) async {
    final notes = await _readAll();
    return notes.where((n) => n.movieId == movieId).firstOrNull;
  }
}
