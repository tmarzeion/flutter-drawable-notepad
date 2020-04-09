import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/font_picker_menu_item.dart';

class NoteRoute extends StatefulWidget {
  NoteRoute({Key key, this.note}) : super(key: key);

  Note note;

  @override
  _NoteRouteState createState() => _NoteRouteState();
}

class _NoteRouteState extends State<NoteRoute> {
  final noteTextController = TextEditingController();


  @override
  void initState() {
    noteTextController.text = widget.note?.noteText ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Note"),
            actions: <Widget>[
              FontPickerMenuItem(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: noteTextController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write Your note here…'),
                  ),
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  Future<bool> _onWillPop() async {
    final database = Provider.of<NotepadDatabase>(context, listen: false);
    final noteText = noteTextController.text;
    if (noteText.isNotEmpty) {
      if (widget.note != null) {
        if (widget.note.noteText != noteText) {
          database.updateNote(widget.note.copyWith(noteText: noteText));
        }
      } else {
        database.insertNote(Note(noteText: noteText, noteDate: new DateTime.now()));
      }
    }
    return true;
  }

}
