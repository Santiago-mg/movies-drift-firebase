import 'package:drift/drift.dart';

@DataClassName('MovieNoteRow')
class MovieNotes extends Table {
  IntColumn get movieId => integer()();
  TextColumn get note => text()();
  IntColumn get rating => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  //debt sync
  BoolColumn get pendingSync => boolean()
                                .withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {movieId};
}