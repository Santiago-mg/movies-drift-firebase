import 'package:drift/drift.dart';

import 'connection/connection.dart';
import 'movie_notes_table.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [MovieNotes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());
  @override
  int get schemaVersion => 1;
}
