import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/list/views/note_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NotesListState();
  }
}

class NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return _buildNotesList();
  }

  StreamBuilder<List<Note>> _buildNotesList() {
    final database = Provider.of<NotepadDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllNotes(),
      builder: (context, AsyncSnapshot snapshot) {
        final notes = snapshot.data ?? List();
        return ListView.separated(
            itemBuilder: (_, index) {
              final itemNote = notes[snapshot.data.length - index - 1]; //TODO Ugly workaroud for reversing list order, IDK how to make that on Moor level
              return NoteItem(
                  key: ObjectKey(itemNote),
                  note: itemNote);
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
              height: 0.0,
            ),
            itemCount: notes.length);
      },
    );
  }
}
