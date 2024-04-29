// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayLesson _$DayLessonFromJson(Map<String, dynamic> json) => DayLesson(
      dateTime: DateTime.parse(json['dateTime'] as String),
      studies: (json['studies'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayLessonToJson(DayLesson instance) => <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'studies': instance.studies,
    };
