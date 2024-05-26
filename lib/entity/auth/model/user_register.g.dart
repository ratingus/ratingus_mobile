// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegister _$UserRegisterFromJson(Map<String, dynamic> json) => UserRegister(
      login: json['login'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      patronymic: json['patronymic'] as String,
      birthdate: DateTime.parse(json['birthdate'] as String),
    );

Map<String, dynamic> _$UserRegisterToJson(UserRegister instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
      'name': instance.name,
      'surname': instance.surname,
      'patronymic': instance.patronymic,
      'birthdate': instance.birthdate.toIso8601String(),
    };
