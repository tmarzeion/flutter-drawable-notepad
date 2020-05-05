// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NoteSettingsConverter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteSettings _$NoteSettingsFromJson(Map<String, dynamic> json) {
  return NoteSettings(
    json['drawMode'] as bool,
    json['paintR'] as int,
    json['paintG'] as int,
    json['paintB'] as int,
    (json['paintThickness'] as num).toDouble(),
  );
}

Map<String, dynamic> _$NoteSettingsToJson(NoteSettings instance) =>
    <String, dynamic>{
      'drawMode': instance.drawMode,
      'paintR': instance.paintR,
      'paintG': instance.paintG,
      'paintB': instance.paintB,
      'paintThickness': instance.paintThickness,
    };
