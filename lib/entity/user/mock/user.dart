import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/user/model/user.dart';

var currentUser = User(
    id: 0,
    login: 'Логин',
    name: 'Имя',
    surname: 'Фамилия',
    patronymic: 'Отчество',
    schoolId: 0,
    classId: ClassItem(id: 17, name: "Класс 9а"),
    birthdate: DateTime.utc(2002, 2, 12));
