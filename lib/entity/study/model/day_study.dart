import 'package:json_annotation/json_annotation.dart';

import 'day_with_studies.dart';
import 'study.dart';

part 'day_study.g.dart';

@JsonSerializable()
class DayStudy extends DayWithStudies<Study> {
  final int dayOfWeek;
  @override
  final List<Study> lessons;

  DayStudy({required this.dayOfWeek, required this.lessons});

  factory DayStudy.fromJson(Map<String, dynamic> json) => _$DayStudyFromJson(json);

  Map<String, dynamic> toJson() => _$DayStudyToJson(this);
}