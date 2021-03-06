import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/intro/intro_route.dart';
import 'package:drawablenotepadflutter/routes/list/list_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';

import 'note/note_route.dart';

class AppNavigator {
  static void navigateToNoteEdit(BuildContext context, Note note, Drawing drawing) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return NoteRoute(
        note: note,
        drawing: drawing,
        previewMode: false,
      );
    }));
  }

  static void navigateToNoteList(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageTransition(type: PageTransitionType.fade, duration: Duration(milliseconds: 1000), child: ListRoute()),
      (Route<dynamic> route) => false,
    );
  }

  // Nullable note
  static void navigateToIntro(BuildContext context, Note note, Drawing drawing) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => OnBoardingPage(note: note, drawing: drawing,)),
      (Route<dynamic> route) => false,
    );
  }
}
