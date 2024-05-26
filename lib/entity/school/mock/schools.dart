import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/school/model/school.dart';
import 'package:ratingus_mobile/entity/user/model/role.dart';

final schools = <School>[
  School(
      id: 0,
      name: "Школа №31415",
      role: UserRole.student,
      classDto:
        ClassItem(id: 17, name: "Класс 9а"),
      ),
  School(
      id: 1,
      name: "Муз. школа №99999",
      role: UserRole.student,
      classDto: ClassItem(id: 3, name: "Скрипка"),),
  School(
      id: 3,
      name: "Школа №777",
      role: UserRole.student,
      classDto:
        ClassItem(id: 5, name: "Английский язык"),
      ),
  School(
      id: 4,
      name: "Подготовительная школа №123124",
      role: UserRole.teacher,
      classDto:
        ClassItem(id: 6, name: "Повышенная информатика"),
      ),
  School(
      id: 5,
      name: "Школа №9999",
      role: UserRole.student,
      classDto:
        ClassItem(id: 7, name: "Кружок рукоделия"),
      ),
];
