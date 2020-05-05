import 'package:drawablenotepadflutter/routes/app_navigator.dart';
import 'package:drawablenotepadflutter/translations.dart';
import 'package:flutter/material.dart';

import 'views/notes_list.dart';

class ListRoute extends StatefulWidget {
  ListRoute({Key key}) : super(key: key);

  static const String routeName = "ListRoute";

  @override
  _ListRouteState createState() => _ListRouteState();
}

class _ListRouteState extends State<ListRoute> {
  bool searchExpanded = false;
  NotesList notesList;
  TextEditingController _searchTextController;
  FocusNode _focusNode = FocusNode();

  final _notesListStateKey = GlobalKey<NotesListState>();

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchWidget = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          opacity: searchExpanded ? 1.0 : 0.0,
          child: IconButton(
            padding: EdgeInsets.all(0.0),
            icon: (Icon(Icons.close, size: 24)),
            onPressed: _toggleSearch,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              height: 50,
              width:
                  searchExpanded ? MediaQuery.of(context).size.width - 48 : 0.0,
              decoration: new BoxDecoration(
                  color: Colors.black.withAlpha(50),
                  borderRadius: new BorderRadius.circular(40.0)),
              child: TextField(
                controller: _searchTextController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, bottom: 7, top: 0, right: 15),
                    hintText: AppLocalizations.of(context)
                        .translate('searchBarTypeToSearch')),
                onChanged: _onSearchQueryChanged,
              )),
        ),
      ],
    );

    Widget searchIcon = AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        opacity: !searchExpanded ? 1.0 : 0.0,
        child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(Icons.search),
              onPressed: () {
                _toggleSearch();
              },
            )));

    notesList = NotesList(
      key: _notesListStateKey,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .translate('notesListRouteToolbarTitle')),
        actions: <Widget>[
          Stack(children: <Widget>[searchWidget, searchIcon])
        ],
      ),
      body: notesList,
      floatingActionButton: FloatingActionButton(
        tooltip: AppLocalizations.of(context).translate('addNoteFABTooltip'),
        onPressed: () => AppNavigator.navigateToNoteEdit(context, null, null),
        child: Icon(Icons.add),
      ),
    );
  }

  void _toggleSearch() {
    setState(() {
      searchExpanded = !searchExpanded;
      _searchTextController.text = "";
      _onSearchQueryChanged("");
      if (searchExpanded) {
        _focusNode.requestFocus();
      } else {
        FocusScope.of(context).requestFocus(new FocusNode());
      }
    });
  }

  void _onSearchQueryChanged(String query) {
    if (_notesListStateKey.currentState != null) {
      _notesListStateKey.currentState.onQueryTextChanged(query);
    }
  }
}
