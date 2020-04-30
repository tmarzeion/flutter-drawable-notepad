import 'package:moor_flutter/moor_flutter.dart';

part 'notepad_database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get paths => text().nullable()();
  TextColumn get noteText => text()();
  TextColumn get notePlainText => text()();
  DateTimeColumn get noteDate => dateTime()();
  TextColumn get noteSettings => text()();
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
  Future<int> insertNote(Note note) => into(notes).insert(note);
  Future updateNote(Note note) => update(notes).replace(note);
  Future deleteNote(Note note) => delete(notes).delete(note);
  Stream<List<Note>> watchEntriesWithText(String searchPlainText) {
    var query = select(notes);
    query.where((t) => t.notePlainText.like('%$searchPlainText%'));
    return query.watch();
  }
}
