import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/material.dart';

class NoteItem extends StatelessWidget {
  NoteItem({this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Text("Content: ${note.noteText}"); //TODO Make rest of this view
  }
}
