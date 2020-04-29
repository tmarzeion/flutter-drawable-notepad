import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:drawablenotepadflutter/routes/init/init_route.dart';
import 'package:drawablenotepadflutter/routes/intro/intro_route.dart';
import 'package:drawablenotepadflutter/routes/note/note_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const.dart';
import 'routes/list/list_route.dart';
import 'translations.dart';

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
        supportedLocales: [
          Locale('en', 'US'),
          Locale('pl'),
          Locale('da'),
          Locale('de'),
          Locale('es', '419'),
          Locale('fr'),
          Locale('ja'),
          Locale('ru'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        title: "Drawble Notepad 2",// AppLocalizations.of(context).translate('appTitle'), //TODO This needs to be translated
        theme: ThemeData(
          primarySwatch: Settings.defaultColor, //Default color here
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitRoute(),
      )
    );
  }
}


