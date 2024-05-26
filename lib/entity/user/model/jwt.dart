import 'package:json_annotation/json_annotation.dart';

part 'jwt.g.dart';

@JsonSerializable()
class JWT {
  final int id;
  final String login;
  final String name;
  final String surname;
  final String patronymic;
  final String? school;
  final String sub;
  final int iat;
  final int exp;

  JWT({
    required this.id,
    required this.login,
    required this.name,
    required this.surname,
    required this.patronymic,
    required this.school,
    required this.sub,
    required this.iat,
    required this.exp,
  });

  String getFio() {
    return '$surname $name $patronymic';
  }

  factory JWT.fromJson(Map<String, dynamic> json) => _$JWTFromJson(json);

  Map<String, dynamic> toJson() => _$JWTToJson(this);
}
