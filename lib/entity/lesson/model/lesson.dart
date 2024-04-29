import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/mark/model/attendance.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/user/model/teacher.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson extends Study {
  final int id;
  final String? mark;
  final Attendance? attendance;

  Lesson({
    this.mark,
    this.attendance,
    required this.id,
    required super.studyId,
    required super.timetableNumber,
    required super.subject,
    required super.teacher,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
