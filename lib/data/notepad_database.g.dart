// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notepad_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Note extends DataClass implements Insertable<Note> {
  final int id;
  final Uint8List bitmap;
  final String noteText;
  final String noteTitle;
  Note(
      {@required this.id,
      this.bitmap,
      @required this.noteText,
      this.noteTitle});
  factory Note.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final uint8ListType = db.typeSystem.forDartType<Uint8List>();
    final stringType = db.typeSystem.forDartType<String>();
    return Note(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      bitmap: uint8ListType
          .mapFromDatabaseResponse(data['${effectivePrefix}bitmap']),
      noteText: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_text']),
      noteTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}note_title']),
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      bitmap: serializer.fromJson<Uint8List>(json['bitmap']),
      noteText: serializer.fromJson<String>(json['noteText']),
      noteTitle: serializer.fromJson<String>(json['noteTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bitmap': serializer.toJson<Uint8List>(bitmap),
      'noteText': serializer.toJson<String>(noteText),
      'noteTitle': serializer.toJson<String>(noteTitle),
    };
  }

  @override
  NotesCompanion createCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      bitmap:
          bitmap == null && nullToAbsent ? const Value.absent() : Value(bitmap),
      noteText: noteText == null && nullToAbsent
          ? const Value.absent()
          : Value(noteText),
      noteTitle: noteTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(noteTitle),
    );
  }

  Note copyWith(
          {int id, Uint8List bitmap, String noteText, String noteTitle}) =>
      Note(
        id: id ?? this.id,
        bitmap: bitmap ?? this.bitmap,
        noteText: noteText ?? this.noteText,
        noteTitle: noteTitle ?? this.noteTitle,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('bitmap: $bitmap, ')
          ..write('noteText: $noteText, ')
          ..write('noteTitle: $noteTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(bitmap.hashCode, $mrjc(noteText.hashCode, noteTitle.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.bitmap == this.bitmap &&
          other.noteText == this.noteText &&
          other.noteTitle == this.noteTitle);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<Uint8List> bitmap;
  final Value<String> noteText;
  final Value<String> noteTitle;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.bitmap = const Value.absent(),
    this.noteText = const Value.absent(),
    this.noteTitle = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.bitmap = const Value.absent(),
    @required String noteText,
    this.noteTitle = const Value.absent(),
  }) : noteText = Value(noteText);
  NotesCompanion copyWith(
      {Value<int> id,
      Value<Uint8List> bitmap,
      Value<String> noteText,
      Value<String> noteTitle}) {
    return NotesCompanion(
      id: id ?? this.id,
      bitmap: bitmap ?? this.bitmap,
      noteText: noteText ?? this.noteText,
      noteTitle: noteTitle ?? this.noteTitle,
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

  final VerificationMeta _bitmapMeta = const VerificationMeta('bitmap');
  GeneratedBlobColumn _bitmap;
  @override
  GeneratedBlobColumn get bitmap => _bitmap ??= _constructBitmap();
  GeneratedBlobColumn _constructBitmap() {
    return GeneratedBlobColumn(
      'bitmap',
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
        minTextLength: 1, maxTextLength: 2048);
  }

  final VerificationMeta _noteTitleMeta = const VerificationMeta('noteTitle');
  GeneratedTextColumn _noteTitle;
  @override
  GeneratedTextColumn get noteTitle => _noteTitle ??= _constructNoteTitle();
  GeneratedTextColumn _constructNoteTitle() {
    return GeneratedTextColumn('note_title', $tableName, true,
        minTextLength: 1, maxTextLength: 256);
  }

  @override
  List<GeneratedColumn> get $columns => [id, bitmap, noteText, noteTitle];
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
    if (d.bitmap.present) {
      context.handle(
          _bitmapMeta, bitmap.isAcceptableValue(d.bitmap.value, _bitmapMeta));
    }
    if (d.noteText.present) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableValue(d.noteText.value, _noteTextMeta));
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    if (d.noteTitle.present) {
      context.handle(_noteTitleMeta,
          noteTitle.isAcceptableValue(d.noteTitle.value, _noteTitleMeta));
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
    if (d.bitmap.present) {
      map['bitmap'] = Variable<Uint8List, BlobType>(d.bitmap.value);
    }
    if (d.noteText.present) {
      map['note_text'] = Variable<String, StringType>(d.noteText.value);
    }
    if (d.noteTitle.present) {
      map['note_title'] = Variable<String, StringType>(d.noteTitle.value);
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
