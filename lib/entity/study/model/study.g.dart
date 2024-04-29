// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Study _$StudyFromJson(Map<String, dynamic> json) => Study(
      studyId: (json['studyId'] as num).toInt(),
      timetableNumber: (json['timetableNumber'] as num).toInt(),
      subject: json['subject'] as String,
      teacher: Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudyToJson(Study instance) => <String, dynamic>{
      'studyId': instance.studyId,
      'timetableNumber': instance.timetableNumber,
      'subject': instance.subject,
      'teacher': instance.teacher,
    };
