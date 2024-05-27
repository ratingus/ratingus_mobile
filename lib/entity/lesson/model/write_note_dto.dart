class WriteNoteDto {
  final int scheduleId;
  final int? lessonId;
  final int? lessonStudentId;
  final DateTime date;
  final String text;

  WriteNoteDto({
    required this.scheduleId,
    this.lessonId,
    this.lessonStudentId,
    required this.text,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'scheduleId': scheduleId,
      'lessonId': lessonId,
      'lessonStudentId': lessonStudentId,
      'date': date.toIso8601String(),
      'text': text,
    };
  }

  factory WriteNoteDto.fromJson(Map<String, dynamic> json) {
    return WriteNoteDto(
      scheduleId: json['scheduleId'] as int,
      lessonId: json['lessonId'] as int,
      lessonStudentId: json['lessonStudentId'] as int,
      date: DateTime.parse(json['date'] as String),
      text: json['text'] as String,
    );
  }
}