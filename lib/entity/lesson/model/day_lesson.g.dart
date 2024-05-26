// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayLesson _$DayLessonFromJson(Map<String, dynamic> json) => DayLesson(
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      dateTime: DateTime.parse(json['dateTime'] as String),
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayLessonToJson(DayLesson instance) => <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'dateTime': instance.dateTime.toIso8601String(),
      'lessons': instance.lessons,
    };
