// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MovieNotesTable extends MovieNotes
    with TableInfo<$MovieNotesTable, MovieNoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MovieNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _movieIdMeta = const VerificationMeta(
    'movieId',
  );
  @override
  late final GeneratedColumn<int> movieId = GeneratedColumn<int>(
    'movie_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    movieId,
    note,
    rating,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movie_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<MovieNoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('movie_id')) {
      context.handle(
        _movieIdMeta,
        movieId.isAcceptableOrUnknown(data['movie_id']!, _movieIdMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {movieId};
  @override
  MovieNoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieNoteRow(
      movieId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}movie_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $MovieNotesTable createAlias(String alias) {
    return $MovieNotesTable(attachedDatabase, alias);
  }
}

class MovieNoteRow extends DataClass implements Insertable<MovieNoteRow> {
  final int movieId;
  final String note;
  final int rating;
  final DateTime updatedAt;
  final bool pendingSync;
  const MovieNoteRow({
    required this.movieId,
    required this.note,
    required this.rating,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['movie_id'] = Variable<int>(movieId);
    map['note'] = Variable<String>(note);
    map['rating'] = Variable<int>(rating);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  MovieNotesCompanion toCompanion(bool nullToAbsent) {
    return MovieNotesCompanion(
      movieId: Value(movieId),
      note: Value(note),
      rating: Value(rating),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory MovieNoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieNoteRow(
      movieId: serializer.fromJson<int>(json['movieId']),
      note: serializer.fromJson<String>(json['note']),
      rating: serializer.fromJson<int>(json['rating']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'movieId': serializer.toJson<int>(movieId),
      'note': serializer.toJson<String>(note),
      'rating': serializer.toJson<int>(rating),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  MovieNoteRow copyWith({
    int? movieId,
    String? note,
    int? rating,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => MovieNoteRow(
    movieId: movieId ?? this.movieId,
    note: note ?? this.note,
    rating: rating ?? this.rating,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  MovieNoteRow copyWithCompanion(MovieNotesCompanion data) {
    return MovieNoteRow(
      movieId: data.movieId.present ? data.movieId.value : this.movieId,
      note: data.note.present ? data.note.value : this.note,
      rating: data.rating.present ? data.rating.value : this.rating,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MovieNoteRow(')
          ..write('movieId: $movieId, ')
          ..write('note: $note, ')
          ..write('rating: $rating, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(movieId, note, rating, updatedAt, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieNoteRow &&
          other.movieId == this.movieId &&
          other.note == this.note &&
          other.rating == this.rating &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class MovieNotesCompanion extends UpdateCompanion<MovieNoteRow> {
  final Value<int> movieId;
  final Value<String> note;
  final Value<int> rating;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  const MovieNotesCompanion({
    this.movieId = const Value.absent(),
    this.note = const Value.absent(),
    this.rating = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  MovieNotesCompanion.insert({
    this.movieId = const Value.absent(),
    required String note,
    required int rating,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
  }) : note = Value(note),
       rating = Value(rating),
       updatedAt = Value(updatedAt);
  static Insertable<MovieNoteRow> custom({
    Expression<int>? movieId,
    Expression<String>? note,
    Expression<int>? rating,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (movieId != null) 'movie_id': movieId,
      if (note != null) 'note': note,
      if (rating != null) 'rating': rating,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  MovieNotesCompanion copyWith({
    Value<int>? movieId,
    Value<String>? note,
    Value<int>? rating,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
  }) {
    return MovieNotesCompanion(
      movieId: movieId ?? this.movieId,
      note: note ?? this.note,
      rating: rating ?? this.rating,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (movieId.present) {
      map['movie_id'] = Variable<int>(movieId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieNotesCompanion(')
          ..write('movieId: $movieId, ')
          ..write('note: $note, ')
          ..write('rating: $rating, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MovieNotesTable movieNotes = $MovieNotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movieNotes];
}

typedef $$MovieNotesTableCreateCompanionBuilder =
    MovieNotesCompanion Function({
      Value<int> movieId,
      required String note,
      required int rating,
      required DateTime updatedAt,
      Value<bool> pendingSync,
    });
typedef $$MovieNotesTableUpdateCompanionBuilder =
    MovieNotesCompanion Function({
      Value<int> movieId,
      Value<String> note,
      Value<int> rating,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
    });

class $$MovieNotesTableFilterComposer
    extends Composer<_$AppDatabase, $MovieNotesTable> {
  $$MovieNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get movieId => $composableBuilder(
    column: $table.movieId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MovieNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $MovieNotesTable> {
  $$MovieNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get movieId => $composableBuilder(
    column: $table.movieId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MovieNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MovieNotesTable> {
  $$MovieNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get movieId =>
      $composableBuilder(column: $table.movieId, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$MovieNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MovieNotesTable,
          MovieNoteRow,
          $$MovieNotesTableFilterComposer,
          $$MovieNotesTableOrderingComposer,
          $$MovieNotesTableAnnotationComposer,
          $$MovieNotesTableCreateCompanionBuilder,
          $$MovieNotesTableUpdateCompanionBuilder,
          (
            MovieNoteRow,
            BaseReferences<_$AppDatabase, $MovieNotesTable, MovieNoteRow>,
          ),
          MovieNoteRow,
          PrefetchHooks Function()
        > {
  $$MovieNotesTableTableManager(_$AppDatabase db, $MovieNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MovieNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MovieNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MovieNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> movieId = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
              }) => MovieNotesCompanion(
                movieId: movieId,
                note: note,
                rating: rating,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
              ),
          createCompanionCallback:
              ({
                Value<int> movieId = const Value.absent(),
                required String note,
                required int rating,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
              }) => MovieNotesCompanion.insert(
                movieId: movieId,
                note: note,
                rating: rating,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MovieNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MovieNotesTable,
      MovieNoteRow,
      $$MovieNotesTableFilterComposer,
      $$MovieNotesTableOrderingComposer,
      $$MovieNotesTableAnnotationComposer,
      $$MovieNotesTableCreateCompanionBuilder,
      $$MovieNotesTableUpdateCompanionBuilder,
      (
        MovieNoteRow,
        BaseReferences<_$AppDatabase, $MovieNotesTable, MovieNoteRow>,
      ),
      MovieNoteRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MovieNotesTableTableManager get movieNotes =>
      $$MovieNotesTableTableManager(_db, _db.movieNotes);
}
