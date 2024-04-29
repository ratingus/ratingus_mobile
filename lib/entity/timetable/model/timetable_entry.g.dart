// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableEntry _$TimetableEntryFromJson(Map<String, dynamic> json) =>
    TimetableEntry(
      timetableNumber: (json['timetableNumber'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTIme: DateTime.parse(json['endTIme'] as String),
    );

Map<String, dynamic> _$TimetableEntryToJson(TimetableEntry instance) =>
    <String, dynamic>{
      'timetableNumber': instance.timetableNumber,
      'startTime': instance.startTime.toIso8601String(),
      'endTIme': instance.endTIme.toIso8601String(),
    };
