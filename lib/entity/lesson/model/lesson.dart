import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/mark/model/attendance.dart';
import 'package:ratingus_mobile/entity/user/model/teacher.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson {
  final String? mark;
  final Attendance? attendance;
  final int scheduleId;
  final int? lessonId;
  final int? studentLessonId;
  final int teacherSubjectId;
  final String subject;
  final Teacher teacher;
  final int timetableNumber;
  final String? homework;
  final String? note;

  Lesson({
    this.mark,
    this.attendance,
    required this.scheduleId,
    this.lessonId,
    this.studentLessonId,
    required this.teacherSubjectId,
    required this.subject,
    required this.teacher,
    required this.timetableNumber,
    this.homework,
    this.note,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
