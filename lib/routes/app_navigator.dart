import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'note/note_route.dart';

class AppNavigator {

  // Nullable note
  static void navigateToNoteEdit(BuildContext context, Note note) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return NoteRoute(note: note);
    }));
  }

}