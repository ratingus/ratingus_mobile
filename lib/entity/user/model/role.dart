
import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
class UserRole {
  final String value;
  final String text;

  UserRole(this.value,this.text);

  const UserRole._(this.value,this.text);

  static const UserRole student = UserRole._('STUDENT', 'Ученик');
  static const UserRole teacher = UserRole._('TEACHER', 'Учитель');
  static const UserRole localAdmin = UserRole._('LOCAL_ADMIN', 'Локальный админ');
  static const UserRole manager = UserRole._('MANAGER', 'Менеджер платформы');

  static UserRole fromString(String value) {
    switch (value) {
      case 'STUDENT':
        return student;
      case 'TEACHER':
        return teacher;
      case 'LOCAL_ADMIN':
        return localAdmin;
      case 'MANAGER':
        return manager;
      default:
        throw ArgumentError('Unknown UserRole value: $value');
    }
  }

  @override
  String toString() => text;

  factory UserRole.fromJson(String value) => UserRole.fromString(value);

  String toJson() => value;
}