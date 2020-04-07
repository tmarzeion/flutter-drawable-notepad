import 'package:moor_flutter/moor_flutter.dart';

part 'notepad_database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  BlobColumn get bitmap => blob().nullable()();
  TextColumn get noteText => text().withLength(min: 1, max: 2048)();
  TextColumn get noteTitle => text().withLength(min: 1, max: 256).nullable()();
}

@UseMoor(tables: [Notes])
class NotepadDatabase extends _$NotepadDatabase {

  NotepadDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
      path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<Note>> getAllNotes() => select(notes).get();
  Stream<List<Note>> watchAllNotes() => select(notes).watch();
  Future insertNote(Note note) => into(notes).insert(note);
  Future updateNote(Note note) => update(notes).replace(note);
  Future deleteNote(Note note) => delete(notes).delete(note);

}