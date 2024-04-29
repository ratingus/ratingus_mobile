import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/mark/model/attendance.dart';
import 'package:ratingus_mobile/entity/user/model/teacher.dart';

part 'lesson_detail.g.dart';

@JsonSerializable()
class LessonDetail extends Lesson {
  final String? homework;
  final String? note;

  LessonDetail({
    this.homework,
    this.note,
    super.mark,
    super.attendance,
    required super.id,
    required super.studyId,
    required super.timetableNumber,
    required super.subject,
    required super.teacher,
  });

  factory LessonDetail.fromJson(Map<String, dynamic> json) =>
      _$LessonDetailFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LessonDetailToJson(this);
}
