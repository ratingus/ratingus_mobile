// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonDetail _$LessonDetailFromJson(Map<String, dynamic> json) => LessonDetail(
      homework: json['homework'] as String?,
      note: json['note'] as String?,
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

Map<String, dynamic> _$LessonDetailToJson(LessonDetail instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'timetableNumber': instance.timetableNumber,
      'subject': instance.subject,
      'teacher': instance.teacher,
      'id': instance.id,
      'mark': instance.mark,
      'attendance': instance.attendance,
      'homework': instance.homework,
      'note': instance.note,
    };
