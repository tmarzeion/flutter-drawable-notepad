import 'package:drawablenotepadflutter/data/notepad_database.dart';
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
        return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (_, index) {
              final itemNote = notes[index];
              return _buildNoteItem(itemNote);
            });
      },
    );
  }

  Widget _buildNoteItem(Note itemNote) {
    return Text(itemNote.noteText); //TODO
  }
}
