
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_dto.g.dart';

@JsonSerializable()
class EditProfileDto  {
  final String? name;
  final String? surname;
  final String? patronymic;
  final String? birthDate;

  EditProfileDto( {this.birthDate,
    this.name,
    this.surname,
    this.patronymic,
  });
  factory EditProfileDto.fromJson(Map<String, dynamic> json) => _$EditProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileDtoToJson(this);
}