import 'package:json_annotation/json_annotation.dart';

part 'user_register.g.dart';

@JsonSerializable()
class UserRegister {
  final String login;
  final String password;
  final String name;
  final String surname;
  final String patronymic;
  final String birthDate;

  UserRegister(
      {
        required this.login,
        required this.password,
        required this.name,
        required this.surname,
        required this.patronymic,
        required this.birthDate});

  factory UserRegister.fromJson(Map<String, dynamic> json) => _$UserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterToJson(this);
}
