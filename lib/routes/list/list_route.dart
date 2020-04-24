import 'package:drawablenotepadflutter/const.dart';
import 'package:drawablenotepadflutter/routes/app_navigator.dart';
import 'package:drawablenotepadflutter/translations.dart';
import 'package:flutter/material.dart';

import 'views/notes_list.dart';

class ListRoute extends StatefulWidget {
  ListRoute({Key key}) : super(key: key);

  @override
  _ListRouteState createState() => _ListRouteState();
}

class _ListRouteState extends State<ListRoute> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('notesListRouteToolbarTitle')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _showSearch();
            },
          ),
        ],
      ),
      body: NotesList(),
      floatingActionButton: FloatingActionButton(
        tooltip: AppLocalizations.of(context).translate('addNoteFABTooltip'),
        onPressed: () => AppNavigator.navigateToNoteEdit(context, null),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showSearch() {
    //TODO TBD
  }
}