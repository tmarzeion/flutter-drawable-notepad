import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/list/list_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      // The single instance of NotepadDatabase
      create: (_) => NotepadDatabase(),
      child: MaterialApp(
        title: 'Drawable Notepad',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ListRoute(),
      )
    );
  }
}


