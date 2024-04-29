// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      mark: json['mark'] as String?,
      attendance: json['attendance'] == null
          ? null
          : Attendance.fromJson(json['attendance'] as String),
      id: (json['id'] as num).toInt(),
      studyId: (json['studyId'] as num).toInt(),
      timetableNumber: (json['timetableNumber'] as num).toInt(),
      subject: json['subject'] as String,
      teacher: Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'studyId': instance.studyId,
      'timetableNumber': instance.timetableNumber,
      'subject': instance.subject,
      'teacher': instance.teacher,
      'id': instance.id,
      'mark': instance.mark,
      'attendance': instance.attendance,
    };
