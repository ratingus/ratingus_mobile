import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/user/model/teacher.dart';

part 'study.g.dart';

@JsonSerializable()
class Study {
  final int teacherSubjectId;
  final int timetableNumber;
  final String subject;
  final Teacher? teacher;
  final DateTime startTime;
  final DateTime endTime;

  Study({
    required this.teacherSubjectId,
    required this.timetableNumber,
    required this.subject,
    required this.teacher,
    required this.startTime,
    required this.endTime,
  });

  factory Study.fromJson(Map<String, dynamic> json) => _$StudyFromJson(json);

  Map<String, dynamic> toJson() => _$StudyToJson(this);

}