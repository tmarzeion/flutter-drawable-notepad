import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import 'views/font_picker_menu_item.dart';

class NoteRoute extends StatefulWidget {
  NoteRoute({Key key, this.note}) : super(key: key);

  Note note;

  @override
  _NoteRouteState createState() => _NoteRouteState();
}

class _NoteRouteState extends State<NoteRoute> {
  /// Allows to control the editor and the document.
  ZefyrController _zefyrController; //TODO bar visibility listener
  PainterController _painterController;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    _zefyrController = ZefyrController(document, onToolbarVisibilityChange: (visible) => {
    print('Toolbar visibility status: $visible')
    });
    _painterController= _getPainterController();
    _focusNode = FocusNode();
  }

  PainterController _getPainterController(){
    PainterController controller=new PainterController();
    controller.thickness=5.0;
    controller.drawColor = Colors.amberAccent;
    controller.backgroundColor= Colors.transparent;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        actions: <Widget>[
          FontPickerMenuItem(),
        ],
      ),
      body: Stack(
        children: [
          ZefyrScaffold(
            child: ZefyrEditor(
              padding: EdgeInsets.all(16),
              controller: _zefyrController,
              focusNode: _focusNode,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: ZefyrToolbar.kToolbarHeight), //TODO Dynamic padding reactive for toolbar visibility changes
            child: Container(
                child: Painter(_painterController
                )),
          )
        ],
      ),
    );
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    // For simplicity we hardcode a simple document with one line of text
    // saying ""Notepad test".
    // (Note that delta must always end with newline.)
    final Delta delta = Delta()..insert("Notepad test\n");
    return NotusDocument.fromDelta(delta);
  }

}
