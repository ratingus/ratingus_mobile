// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Timetable _$TimetableFromJson(Map<String, dynamic> json) => Timetable(
      timetableId: (json['timetableId'] as num).toInt(),
      timetableEntry: (json['timetableEntry'] as List<dynamic>)
          .map((e) => TimetableEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TimetableToJson(Timetable instance) => <String, dynamic>{
      'timetableId': instance.timetableId,
      'timetableEntry': instance.timetableEntry,
    };
