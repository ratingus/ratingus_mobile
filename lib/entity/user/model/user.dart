import 'package:ratingus_mobile/entity/class/model/class_model.dart';

class User {
  final int id;
  final String login;
  final String name;
  final String surname;
  final String patronymic;
  final int schoolId;
  final ClassItem classId;
  final DateTime birthdate;

  User(
      {required this.id,
      required this.login,
      required this.name,
      required this.surname,
      required this.patronymic,
      required this.schoolId,
      required this.classId,
      required this.birthdate});

  String getFio() {
    return '$surname $name $patronymic';
  }
}
