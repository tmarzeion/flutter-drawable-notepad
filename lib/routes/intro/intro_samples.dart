import 'dart:convert';

import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/widgets.dart';

class IntroSamples {

  static Future<Note> getSampleNote(BuildContext context) async {
    Map<String, dynamic> deserialized = json.decode(await fetchSampleJson(context));
    return Note(
      id: deserialized["id"] as int,
      paths: deserialized["paths"] as String,
      noteText: deserialized["noteText"] as String,
      noteDate: new DateTime.now(),
      noteSettings: deserialized["noteSettings"] as String,
    );
  }

  static Future<String> fetchSampleJson(BuildContext context) async {
    return DefaultAssetBundle.of(context).loadString("assets/sample_note.json");
  }

}