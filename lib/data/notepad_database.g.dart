// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notepad_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Note extends DataClass implements Insertable<Note> {
  final int id;
  final int drawingId;
  final String noteText;
  final String notePlainText;
  final DateTime noteDate;
  final String noteSettings;
  Note(
      {@required this.id,
      this.drawingId,
      @required this.noteText,
      @required this.notePlainText,
      @required this.noteDate,
      @required this.noteSettings});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Note(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      drawingId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}drawing_id']),
      noteText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_text']),
      notePlainText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_plain_text']),
      noteDate: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_date']),
      noteSettings: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_settings']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      drawingId: serializer.fromJson<int>(json['drawingId']),
      noteText: serializer.fromJson<String>(json['noteText']),
      notePlainText: serializer.fromJson<String>(json['notePlainText']),
      noteDate: serializer.fromJson<DateTime>(json['noteDate']),
      noteSettings: serializer.fromJson<String>(json['noteSettings']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'drawingId': serializer.toJson<int>(drawingId),
      'noteText': serializer.toJson<String>(noteText),
      'notePlainText': serializer.toJson<String>(notePlainText),
      'noteDate': serializer.toJson<DateTime>(noteDate),
      'noteSettings': serializer.toJson<String>(noteSettings),
    };
  }

  @override
  NotesCompanion createCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      drawingId: drawingId == null && nullToAbsent
          ? const Value.absent()
          : Value(drawingId),
      noteText: noteText == null && nullToAbsent
          ? const Value.absent()
          : Value(noteText),
      notePlainText: notePlainText == null && nullToAbsent
          ? const Value.absent()
          : Value(notePlainText),
      noteDate: noteDate == null && nullToAbsent
          ? const Value.absent()
          : Value(noteDate),
      noteSettings: noteSettings == null && nullToAbsent
          ? const Value.absent()
          : Value(noteSettings),
    );
  }

  Note copyWith(
          {int id,
          int drawingId,
          String noteText,
          String notePlainText,
          DateTime noteDate,
          String noteSettings}) =>
      Note(
        id: id ?? this.id,
        drawingId: drawingId ?? this.drawingId,
        noteText: noteText ?? this.noteText,
        notePlainText: notePlainText ?? this.notePlainText,
        noteDate: noteDate ?? this.noteDate,
        noteSettings: noteSettings ?? this.noteSettings,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('drawingId: $drawingId, ')
          ..write('noteText: $noteText, ')
          ..write('notePlainText: $notePlainText, ')
          ..write('noteDate: $noteDate, ')
          ..write('noteSettings: $noteSettings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          drawingId.hashCode,
          $mrjc(
              noteText.hashCode,
              $mrjc(notePlainText.hashCode,
                  $mrjc(noteDate.hashCode, noteSettings.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.drawingId == this.drawingId &&
          other.noteText == this.noteText &&
          other.notePlainText == this.notePlainText &&
          other.noteDate == this.noteDate &&
          other.noteSettings == this.noteSettings);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<int> drawingId;
  final Value<String> noteText;
  final Value<String> notePlainText;
  final Value<DateTime> noteDate;
  final Value<String> noteSettings;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.drawingId = const Value.absent(),
    this.noteText = const Value.absent(),
    this.notePlainText = const Value.absent(),
    this.noteDate = const Value.absent(),
    this.noteSettings = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.drawingId = const Value.absent(),
    @required String noteText,
    @required String notePlainText,
    @required DateTime noteDate,
    @required String noteSettings,
  })  : noteText = Value(noteText),
        notePlainText = Value(notePlainText),
        noteDate = Value(noteDate),
        noteSettings = Value(noteSettings);
  NotesCompanion copyWith(
      {Value<int> id,
      Value<int> drawingId,
      Value<String> noteText,
      Value<String> notePlainText,
      Value<DateTime> noteDate,
      Value<String> noteSettings}) {
    return NotesCompanion(
      id: id ?? this.id,
      drawingId: drawingId ?? this.drawingId,
      noteText: noteText ?? this.noteText,
      notePlainText: notePlainText ?? this.notePlainText,
      noteDate: noteDate ?? this.noteDate,
      noteSettings: noteSettings ?? this.noteSettings,
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

  final VerificationMeta _drawingIdMeta = const VerificationMeta('drawingId');
  GeneratedIntColumn _drawingId;
  @override
  GeneratedIntColumn get drawingId => _drawingId ??= _constructDrawingId();
  GeneratedIntColumn _constructDrawingId() {
    return GeneratedIntColumn(
      'drawing_id',
      $tableName,
      true,
    );
  }

  final VerificationMeta _noteTextMeta = const VerificationMeta('noteText');
  GeneratedTextColumn _noteText;
  @override
  GeneratedTextColumn get noteText => _noteText ??= _constructNoteText();
  GeneratedTextColumn _constructNoteText() {
    return GeneratedTextColumn(
      'note_text',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notePlainTextMeta =
      const VerificationMeta('notePlainText');
  GeneratedTextColumn _notePlainText;
  @override
  GeneratedTextColumn get notePlainText =>
      _notePlainText ??= _constructNotePlainText();
  GeneratedTextColumn _constructNotePlainText() {
    return GeneratedTextColumn(
      'note_plain_text',
      $tableName,
      false,
    );
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

  final VerificationMeta _noteSettingsMeta =
      const VerificationMeta('noteSettings');
  GeneratedTextColumn _noteSettings;
  @override
  GeneratedTextColumn get noteSettings =>
      _noteSettings ??= _constructNoteSettings();
  GeneratedTextColumn _constructNoteSettings() {
    return GeneratedTextColumn(
      'note_settings',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, drawingId, noteText, notePlainText, noteDate, noteSettings];
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
    if (d.drawingId.present) {
      context.handle(_drawingIdMeta,
          drawingId.isAcceptableValue(d.drawingId.value, _drawingIdMeta));
    }
    if (d.noteText.present) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableValue(d.noteText.value, _noteTextMeta));
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    if (d.notePlainText.present) {
      context.handle(
          _notePlainTextMeta,
          notePlainText.isAcceptableValue(
              d.notePlainText.value, _notePlainTextMeta));
    } else if (isInserting) {
      context.missing(_notePlainTextMeta);
    }
    if (d.noteDate.present) {
      context.handle(_noteDateMeta,
          noteDate.isAcceptableValue(d.noteDate.value, _noteDateMeta));
    } else if (isInserting) {
      context.missing(_noteDateMeta);
    }
    if (d.noteSettings.present) {
      context.handle(
          _noteSettingsMeta,
          noteSettings.isAcceptableValue(
              d.noteSettings.value, _noteSettingsMeta));
    } else if (isInserting) {
      context.missing(_noteSettingsMeta);
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
    if (d.drawingId.present) {
      map['drawing_id'] = Variable<int, IntType>(d.drawingId.value);
    }
    if (d.noteText.present) {
      map['note_text'] = Variable<String, StringType>(d.noteText.value);
    }
    if (d.notePlainText.present) {
      map['note_plain_text'] =
          Variable<String, StringType>(d.notePlainText.value);
    }
    if (d.noteDate.present) {
      map['note_date'] = Variable<DateTime, DateTimeType>(d.noteDate.value);
    }
    if (d.noteSettings.present) {
      map['note_settings'] = Variable<String, StringType>(d.noteSettings.value);
    }
    return map;
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(_db, alias);
  }
}

class Drawing extends DataClass implements Insertable<Drawing> {
  final int id;
  final String paths;
  Drawing({@required this.id, this.paths});
  factory Drawing.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Drawing(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      paths:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}paths']),
    );
  }
  factory Drawing.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Drawing(
      id: serializer.fromJson<int>(json['id']),
      paths: serializer.fromJson<String>(json['paths']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'paths': serializer.toJson<String>(paths),
    };
  }

  @override
  DrawingsCompanion createCompanion(bool nullToAbsent) {
    return DrawingsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      paths:
          paths == null && nullToAbsent ? const Value.absent() : Value(paths),
    );
  }

  Drawing copyWith({int id, String paths}) => Drawing(
        id: id ?? this.id,
        paths: paths ?? this.paths,
      );
  @override
  String toString() {
    return (StringBuffer('Drawing(')
          ..write('id: $id, ')
          ..write('paths: $paths')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, paths.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Drawing && other.id == this.id && other.paths == this.paths);
}

class DrawingsCompanion extends UpdateCompanion<Drawing> {
  final Value<int> id;
  final Value<String> paths;
  const DrawingsCompanion({
    this.id = const Value.absent(),
    this.paths = const Value.absent(),
  });
  DrawingsCompanion.insert({
    this.id = const Value.absent(),
    this.paths = const Value.absent(),
  });
  DrawingsCompanion copyWith({Value<int> id, Value<String> paths}) {
    return DrawingsCompanion(
      id: id ?? this.id,
      paths: paths ?? this.paths,
    );
  }
}

class $DrawingsTable extends Drawings with TableInfo<$DrawingsTable, Drawing> {
  final GeneratedDatabase _db;
  final String _alias;
  $DrawingsTable(this._db, [this._alias]);
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

  @override
  List<GeneratedColumn> get $columns => [id, paths];
  @override
  $DrawingsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'drawings';
  @override
  final String actualTableName = 'drawings';
  @override
  VerificationContext validateIntegrity(DrawingsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    }
    if (d.paths.present) {
      context.handle(
          _pathsMeta, paths.isAcceptableValue(d.paths.value, _pathsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Drawing map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Drawing.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DrawingsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.paths.present) {
      map['paths'] = Variable<String, StringType>(d.paths.value);
    }
    return map;
  }

  @override
  $DrawingsTable createAlias(String alias) {
    return $DrawingsTable(_db, alias);
  }
}

abstract class _$NotepadDatabase extends GeneratedDatabase {
  _$NotepadDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $NotesTable _notes;
  $NotesTable get notes => _notes ??= $NotesTable(this);
  $DrawingsTable _drawings;
  $DrawingsTable get drawings => _drawings ??= $DrawingsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notes, drawings];
}
