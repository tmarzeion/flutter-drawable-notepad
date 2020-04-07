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
  Note({@required this.id, this.bitmap, @required this.noteText});
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
    );
  }
  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<int>(json['id']),
      bitmap: serializer.fromJson<Uint8List>(json['bitmap']),
      noteText: serializer.fromJson<String>(json['noteText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bitmap': serializer.toJson<Uint8List>(bitmap),
      'noteText': serializer.toJson<String>(noteText),
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
    );
  }

  Note copyWith({int id, Uint8List bitmap, String noteText}) => Note(
        id: id ?? this.id,
        bitmap: bitmap ?? this.bitmap,
        noteText: noteText ?? this.noteText,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('bitmap: $bitmap, ')
          ..write('noteText: $noteText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(bitmap.hashCode, noteText.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.bitmap == this.bitmap &&
          other.noteText == this.noteText);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<int> id;
  final Value<Uint8List> bitmap;
  final Value<String> noteText;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.bitmap = const Value.absent(),
    this.noteText = const Value.absent(),
  });
  NotesCompanion.insert({
    this.id = const Value.absent(),
    this.bitmap = const Value.absent(),
    @required String noteText,
  }) : noteText = Value(noteText);
  NotesCompanion copyWith(
      {Value<int> id, Value<Uint8List> bitmap, Value<String> noteText}) {
    return NotesCompanion(
      id: id ?? this.id,
      bitmap: bitmap ?? this.bitmap,
      noteText: noteText ?? this.noteText,
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

  @override
  List<GeneratedColumn> get $columns => [id, bitmap, noteText];
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
