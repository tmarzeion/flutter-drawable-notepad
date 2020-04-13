import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/notes_list.dart';

class ListRoute extends StatefulWidget {
  ListRoute({Key key}) : super(key: key);

  @override
  _ListRouteState createState() => _ListRouteState();
}

class _ListRouteState extends State<ListRoute> {
  MenuItem _selectedChoice = mainMenuItems[0];

  void _select(MenuItem choice) {
    // Causes the app to rebuild with the new _selectedChoice.

    final database = Provider.of<NotepadDatabase>(context, listen: false);
    var testDate = new DateTime(2020, 4, 0);
    database.insertNote(Note(noteText: "SomeTxt ${new DateTime.now().millisecondsSinceEpoch}", noteDate: testDate));

    setState(() {
      _selectedChoice = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("Notepad"),
        actions: <Widget>[
          IconButton(
            icon: Icon(mainMenuItems[0].icon),
            onPressed: () {
              _select(mainMenuItems[0]); //TODO TBD
            },
          ),
        ],
      ),
      body: NotesList(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add note',
        onPressed: () => AppNavigator.navigateToNoteEdit(context, null),
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MenuItem {
  const MenuItem({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<MenuItem> mainMenuItems = const <MenuItem>[
  const MenuItem(title: 'Search', icon: Icons.search),
];
