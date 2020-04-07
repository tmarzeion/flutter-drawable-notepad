import 'package:flutter/material.dart';

import 'views/font_picker_menu_item.dart';

class NoteRoute extends StatefulWidget {
  NoteRoute({Key key}) : super(key: key);

  @override
  _NoteRouteState createState() => _NoteRouteState();
}

class _NoteRouteState extends State<NoteRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
