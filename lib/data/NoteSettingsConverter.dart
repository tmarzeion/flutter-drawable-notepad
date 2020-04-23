import 'notepad_database.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'NoteSettingsConverter.g.dart';

@JsonSerializable(nullable: false)
class NoteSettings {
  bool drawMode;
  int paintR;
  int paintG;
  int paintB;
  double paintThickness;

  NoteSettings(this.drawMode, this.paintR, this.paintG, this.paintB,
      this.paintThickness);

  factory NoteSettings.fromJson(Map<String, dynamic> json) => _$NoteSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$NoteSettingsToJson(this);

}

class NoteSettingsConverter {
  static NoteSettings fromNote(Note note) {
    return NoteSettings.fromJson(jsonDecode(note.noteSettings));
  }
}