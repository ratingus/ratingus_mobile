import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/user/model/role.dart';

part 'school.g.dart';

@JsonSerializable()
class School {
  final int id;
  final String name;
  final UserRole role;
  final ClassItem? classDto;

  School({
    required this.id,
    required this.name,
    required this.role,
    this.classDto,
  });

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}