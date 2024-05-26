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
      scheduleId: (json['scheduleId'] as num).toInt(),
      lessonId: (json['lessonId'] as num?)?.toInt(),
      studentLessonId: (json['studentLessonId'] as num?)?.toInt(),
      teacherSubjectId: (json['teacherSubjectId'] as num).toInt(),
      subject: json['subject'] as String,
      teacher: Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      timetableNumber: (json['timetableNumber'] as num).toInt(),
      homework: json['homework'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'mark': instance.mark,
      'attendance': instance.attendance,
      'scheduleId': instance.scheduleId,
      'lessonId': instance.lessonId,
      'studentLessonId': instance.studentLessonId,
      'teacherSubjectId': instance.teacherSubjectId,
      'subject': instance.subject,
      'teacher': instance.teacher,
      'timetableNumber': instance.timetableNumber,
      'homework': instance.homework,
      'note': instance.note,
    };
