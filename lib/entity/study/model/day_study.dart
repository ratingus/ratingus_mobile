import 'package:json_annotation/json_annotation.dart';

import 'study.dart';

part 'day_study.g.dart';

@JsonSerializable()
class DayStudy {
  final int dayOfWeek;
  final List<Study> studies;

  DayStudy({required this.dayOfWeek, required this.studies});

  factory DayStudy.fromJson(Map<String, dynamic> json) => _$DayStudyFromJson(json);

  Map<String, dynamic> toJson() => _$DayStudyToJson(this);
}