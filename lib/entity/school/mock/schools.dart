import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/school/model/school.dart';
import 'package:ratingus_mobile/entity/user/model/role.dart';

final schools = <School>[
  School(
      id: 0,
      name: "Школа №31415",
      address: "г. Москва, ул. Ленина, д. 1",
      phone: "+7 (999) 123-45-67",
      email: "school_31415@school.edu",
      role: UserRole.student,
      classes: [
        ClassItem(id: 0, name: "Класс 9а"),
      ]),
  School(
      id: 1,
      name: "Муз. школа №99999",
      address: "г. Москва, ул. Пушкина, д. 3",
      phone: "+7 (495) 123-45-67",
      email: "muz_school_99999@school.edu",
      role: UserRole.student,
      classes: [
        ClassItem(id: 3, name: "Скрипка"),
        ClassItem(id: 4, name: "Хор"),
      ]),
  School(
      id: 3,
      name: "Школа №777",
      address: "г. Москва, ул. Ленина, д. 1",
      phone: "+7 (999) 123-45-67",
      email: "school_31415@school.edu",
      role: UserRole.student,
      classes: [
        ClassItem(id: 5, name: "Английский язык"),
      ]),
  School(
      id: 4,
      name: "Подготовительная школа №123124",
      address: "г. Москва, ул. Ленина, д. 1",
      phone: "+7 (999) 123-45-67",
      email: "school_31415@school.edu",
      role: UserRole.teacher,
      classes: [
        ClassItem(id: 6, name: "Повышенная информатика"),
      ]),
  School(
      id: 5,
      name: "Школа №9999",
      address: "г. Москва, ул. Ленина, д. 1",
      phone: "+7 (999) 123-45-67",
      email: "school_31415@school.edu",
      role: UserRole.student,
      classes: [
        ClassItem(id: 7, name: "Кружок рукоделия"),
      ]),
];
