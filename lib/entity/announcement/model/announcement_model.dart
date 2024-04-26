class ClassItem {
  final int id;
  final String name;

  ClassItem({required this.id, required this.name});

  factory ClassItem.fromJson(Map<String, dynamic> json) {
    return ClassItem(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Announcement {
  final String fullName;
  final DateTime date;
  final int views;
  final List<ClassItem> classes;
  final String title;
  final String? content;

  Announcement({
    required this.fullName,
    required this.date,
    required this.views,
    required this.classes,
    required this.title,
    this.content,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    var classList = json['classes'] as List;
    List<ClassItem> classesList =
        classList.map((i) => ClassItem.fromJson(i)).toList();

    return Announcement(
      fullName: json['fullName'],
      date: DateTime.parse(json['date']),
      views: json['views'],
      classes: classesList,
      title: json['title'],
      content: json['content'],
    );
  }
}
