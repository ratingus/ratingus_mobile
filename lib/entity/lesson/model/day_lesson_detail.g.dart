// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_lesson_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayLessonDetail _$DayLessonDetailFromJson(Map<String, dynamic> json) =>
    DayLessonDetail(
      dateTime: DateTime.parse(json['dateTime'] as String),
      studies: (json['studies'] as List<dynamic>)
          .map((e) => LessonDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayLessonDetailToJson(DayLessonDetail instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'studies': instance.studies,
    };
