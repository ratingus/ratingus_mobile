import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher  {
  final int id;
  final String name;
  final String surname;
  final String patronymic;

  Teacher({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
  });

  String getFio() {
    return '$surname $name $patronymic';
  }

  factory Teacher.fromJson(Map<String, dynamic> json) => _$TeacherFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}