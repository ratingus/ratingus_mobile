import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/user/model/teacher.dart';

class Announcement {
  final int id;
  final int views;
  final Teacher creator;
  final DateTime createDate;
  final List<ClassItem> classes;
  final String name;
  final String? content;

  Announcement({
    required this.id,
    required this.views,
    required this.creator,
    required this.createDate,
    required this.classes,
    required this.name,
    this.content,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'],
      views: json['views'],
      creator: Teacher.fromJson(json['creator']),
      createDate: DateTime.parse(json['createDate']),
      classes: (json['classes'] as List).map((e) => ClassItem.fromJson(e)).toList(),
      name: json['name'],
      content: json['content'],
    );
  }
}
