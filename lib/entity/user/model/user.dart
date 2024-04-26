class User {
  final int id;
  final String login;
  final String name;
  final String surname;
  final String patronymic;
  final int schoolId;
  final int classId;
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
}
