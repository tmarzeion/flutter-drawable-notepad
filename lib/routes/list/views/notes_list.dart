import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/list/views/note_item.dart';
import 'package:drawablenotepadflutter/routes/note/note_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const.dart';

class NotesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NotesListState();
  }
}

class NotesListState extends State<NotesList> {
  bool modalVisible = false;
  Note visibleNote;

  var currentNoteRoute = null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildNotesList(),
        IgnorePointer(
          ignoring: !modalVisible,
          child: AnimatedOpacity(
            onEnd: () => {
              if (!modalVisible)
                {
                  setState(() => {currentNoteRoute = null})
                }
            },
            opacity: modalVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: currentNoteRoute,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  StreamBuilder<List<Note>> _buildNotesList() {
    final database = Provider.of<NotepadDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllNotes(),
      builder: (context, AsyncSnapshot snapshot) {
        final notes = snapshot.data ?? List();
        return ListView.separated(
            itemBuilder: (_, index) {
              final itemNote = notes[snapshot.data.length -
                  index -
                  1]; //TODO Ugly workaroud for reversing list order, IDK how to make that on Moor level
              return NoteItem(
                key: ObjectKey(itemNote),
                note: itemNote,
                onNotePreviewRequested: (note, show) => {
                  if (show) {_showModal(note)} else {_cancelModal()}
                },
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: Settings.noteItemSeparatorColor,
                  height: 0.0,
                ),
            itemCount: notes.length);
      },
    );
  }

  _showModal(Note note) {
    setState(() {
      currentNoteRoute = NoteRoute(note: note, previewMode: true);
      modalVisible = true;
    });
  }

  _cancelModal() {
    setState(() {
      currentNoteRoute = null;
      modalVisible = false;
    });
  }
}
