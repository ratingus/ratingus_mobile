import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/study/model/day_with_studies.dart';

import 'lesson.dart';

part 'day_lesson.g.dart';

@JsonSerializable()
class DayLesson extends DayWithStudies<Lesson> {
  final int dayOfWeek;
  final DateTime dateTime;
  @override
  final List<Lesson> studies;

  DayLesson({required this.dayOfWeek, required this.dateTime, required this.studies});

  factory DayLesson.fromJson(Map<String, dynamic> json) => _$DayLessonFromJson(json);

  Map<String, dynamic> toJson() => _$DayLessonToJson(this);
}