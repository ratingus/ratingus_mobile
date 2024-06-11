// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfileDto _$EditProfileDtoFromJson(Map<String, dynamic> json) =>
    EditProfileDto(
      birthDate: json['birthDate'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      patronymic: json['patronymic'] as String?,
    );

Map<String, dynamic> _$EditProfileDtoToJson(EditProfileDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'patronymic': instance.patronymic,
      'birthDate': instance.birthDate,
    };
