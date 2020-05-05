import 'dart:convert';

import 'package:drawablenotepadflutter/data/notepad_database.dart';
import 'package:flutter/widgets.dart';

class IntroSamples {

  static Future<Note> getSampleNote(BuildContext context) async {
    Map<String, dynamic> noteJsonMap = json.decode(await fetchSampleNoteJson(context));
    return Note(
      id: noteJsonMap["id"] as int,
      drawingId: 2137,
      noteText: noteJsonMap["noteText"] as String,
      noteDate: new DateTime.now(),
      noteSettings: noteJsonMap["noteSettings"] as String,
    );
  }

  static Future<Drawing> getSampleDrawing(BuildContext context) async {
    Map<String, dynamic> drawingJsonMap = json.decode(await fetchSampleDrawingJson(context));
    return Drawing(
      id: drawingJsonMap["id"] as int,
      paths: drawingJsonMap["paths"] as String,
    );
  }

  static Future<String> fetchSampleNoteJson(BuildContext context) async {
    return DefaultAssetBundle.of(context).loadString("assets/sample_note.json");
  }

  static Future<String> fetchSampleDrawingJson(BuildContext context) async {
    return DefaultAssetBundle.of(context).loadString("assets/sample_drawing.json");
  }

}