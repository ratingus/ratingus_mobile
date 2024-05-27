import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/mark/model/attendance.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/user/model/teacher.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson extends Study {
  final int scheduleId;
  final int? lessonId;
  final int? studentLessonId;
  final String? mark;
  final Attendance? attendance;
  final String? homework;
  final String? note;

  Lesson({
    this.mark,
    this.attendance,
    required this.scheduleId,
    this.lessonId,
    this.studentLessonId,
    required super.teacherSubjectId,
    required super.subject,
    super.teacher,
    required super.timetableNumber,
    required super.startTime,
    required super.endTime,
    this.homework,
    this.note,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
