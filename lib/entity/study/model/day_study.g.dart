// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_study.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayStudy _$DayStudyFromJson(Map<String, dynamic> json) => DayStudy(
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      studies: (json['studies'] as List<dynamic>)
          .map((e) => Study.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayStudyToJson(DayStudy instance) => <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'studies': instance.studies,
    };
