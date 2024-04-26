class UserRole {
  final String value;

  const UserRole._(this.value);

  static const UserRole student = UserRole._('Ученик');
  static const UserRole teacher = UserRole._('Учитель');
  static const UserRole localAdmin = UserRole._('Локальный админ');
  static const UserRole manager = UserRole._('Менеджер платформы');

  static UserRole fromString(String value) {
    switch (value) {
      case 'Ученик':
        return student;
      case 'Учитель':
        return teacher;
      case 'Локальный админ':
        return localAdmin;
      case 'Менеджер платформы':
        return manager;
      default:
        throw ArgumentError('Unknown UserRole value: $value');
    }
  }

  @override
  String toString() => value;
}