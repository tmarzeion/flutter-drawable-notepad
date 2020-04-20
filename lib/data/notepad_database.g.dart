// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notepad_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Note extends DataClass implements Insertable<Note> {
  final int id;
  final String paths;
  final String noteText;
  final DateTime noteDate;
  Note(
      {@required this.id,
      this.paths,
      @required this.noteText,
      @required this.noteDate});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Note(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      paths:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}paths']),
      noteText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_text']),
      noteDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_date']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      paths: serializer.fromJson<String>(json['paths']),
      noteText: serializer.fromJson<String>(json['noteText']),
      noteDate: serializer.fromJson<DateTime>(json['noteDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'paths': serializer.toJson<String>(paths),
      'noteText': serializer.toJson<String>(noteText),
      'noteDate': serializer.toJson<DateTime>(noteDate),
    };
  }

  @override
  NotesCompanion createCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      paths:
          paths == null && nullToAbsent ? const Value.absent() : Value(paths),
      noteText: noteText == null && nullToAbsent
          ? const Value.absent()
          : Value(noteText),
      noteDate: noteDate == null && nullToAbsent
          ? const Value.absent()
          : Value(noteDate),
    );
  }

  Note copyWith({int id, String paths, String noteText, DateTime noteDate}) =>
      Note(
        id: id ?? this.id,
        paths: paths ?? this.paths,
        noteText: noteText ?? this.noteText,
        noteDate: noteDate ?? this.noteDate,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('paths: $paths, ')
          ..write('noteText: $noteText, ')
          ..write('noteDate: $noteDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(paths.hashCode, $mrjc(noteText.hashCode, noteDate.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.paths == this.paths &&
          other.noteText == this.noteText &&
          other.noteDate == this.noteDate);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<String> paths;
  final Value<String> noteText;
  final Value<DateTime> noteDate;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.paths = const Value.absent(),
    this.noteText = const Value.absent(),
    this.noteDate = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.paths = const Value.absent(),
    @required String noteText,
    @required DateTime noteDate,
  })  : noteText = Value(noteText),
        noteDate = Value(noteDate);
  NotesCompanion copyWith(
      {Value<int> id,
      Value<String> paths,
      Value<String> noteText,
      Value<DateTime> noteDate}) {
    return NotesCompanion(
      id: id ?? this.id,
      paths: paths ?? this.paths,
      noteText: noteText ?? this.noteText,
      noteDate: noteDate ?? this.noteDate,
    );
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  final GeneratedDatabase _db;
  final String _alias;
  $NotesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _pathsMeta = const VerificationMeta('paths');
  GeneratedTextColumn _paths;
  @override
  GeneratedTextColumn get paths => _paths ??= _constructPaths();
  GeneratedTextColumn _constructPaths() {
    return GeneratedTextColumn(
      'paths',
      $tableName,
      true,
    );
  }

  final VerificationMeta _noteTextMeta = const VerificationMeta('noteText');
  GeneratedTextColumn _noteText;
  @override
  GeneratedTextColumn get noteText => _noteText ??= _constructNoteText();
  GeneratedTextColumn _constructNoteText() {
    return GeneratedTextColumn('note_text', $tableName, false,
        minTextLength: 1, maxTextLength: 16384);
  }

  final VerificationMeta _noteDateMeta = const VerificationMeta('noteDate');
  GeneratedDateTimeColumn _noteDate;
  @override
  GeneratedDateTimeColumn get noteDate => _noteDate ??= _constructNoteDate();
  GeneratedDateTimeColumn _constructNoteDate() {
    return GeneratedDateTimeColumn(
      'note_date',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, paths, noteText, noteDate];
  @override
  $NotesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'notes';
  @override
  final String actualTableName = 'notes';
  @override
  VerificationContext validateIntegrity(NotesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.paths.present) {
      context.handle(
          _pathsMeta, paths.isAcceptableValue(d.paths.value, _pathsMeta));
    }
    if (d.noteText.present) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableValue(d.noteText.value, _noteTextMeta));
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    if (d.noteDate.present) {
      context.handle(_noteDateMeta,
          noteDate.isAcceptableValue(d.noteDate.value, _noteDateMeta));
    } else if (isInserting) {
      context.missing(_noteDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Note.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NotesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.paths.present) {
      map['paths'] = Variable<String, StringType>(d.paths.value);
    }
    if (d.noteText.present) {
      map['note_text'] = Variable<String, StringType>(d.noteText.value);
    }
    if (d.noteDate.present) {
      map['note_date'] = Variable<DateTime, DateTimeType>(d.noteDate.value);
    }
    return map;
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

abstract class _$NotepadDatabase extends GeneratedDatabase {
  _$NotepadDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes];
}
