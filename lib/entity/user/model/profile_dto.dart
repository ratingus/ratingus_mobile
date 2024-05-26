import 'package:json_annotation/json_annotation.dart';
import 'package:ratingus_mobile/entity/school/model/school.dart';

part 'profile_dto.g.dart';

@JsonSerializable()
class ProfileDto  {
  final int id;
  final String login;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthdate;
  final List<School> schools;

  ProfileDto(this.login, this.birthdate, this.schools, {
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
  });

  String getFio() {
    return '$surname $name $patronymic';
  }

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);
}