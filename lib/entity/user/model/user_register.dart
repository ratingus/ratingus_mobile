class UserRegister {
  final int id;
  final String login;
  final String password;
  final String name;
  final String surname;
  final String patronymic;
  final DateTime birthdate;

  UserRegister(
      {required this.id,
        required this.login,
        required this.password,
        required this.name,
        required this.surname,
        required this.patronymic,
        required this.birthdate});
}
