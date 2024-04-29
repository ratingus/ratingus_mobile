import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/user/model/role.dart';

class School {
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final UserRole role;
  final List<ClassItem> classes;

  School({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.role,
    required this.classes,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      role: UserRole.fromString(json['role']),
      classes: (json['classes'] as List<dynamic>)
          .map((e) => ClassItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'role': role.toString(),
      'classes': classes.map((e) => e.toJson()).toList(),
    };
  }
}