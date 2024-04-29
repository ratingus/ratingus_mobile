import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson_detail.dart';
import 'package:ratingus_mobile/entity/study/model/day_with_studies.dart';

part 'day_lesson_detail.g.dart';

@JsonSerializable()
class DayLessonDetail extends DayWithStudies<LessonDetail> {
  final DateTime dateTime;
  @override
  final List<LessonDetail> studies;

  DayLessonDetail({required this.dateTime, required this.studies});

  factory DayLessonDetail.fromJson(Map<String, dynamic> json) =>
      _$DayLessonDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DayLessonDetailToJson(this);
}
