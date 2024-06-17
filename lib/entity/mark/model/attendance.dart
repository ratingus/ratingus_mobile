import 'package:json_annotation/json_annotation.dart';

part 'attendance.g.dart';

@JsonSerializable()
class Attendance {
  final String value;

  Attendance(this.value);

  const Attendance._(this.value);

  static const Attendance late = Attendance._('Опоздал');
  static const Attendance validAbsent = Attendance._('Уважительная причина');
  static const Attendance invalidAbsent = Attendance._('Неуважительная причина');

  static Attendance fromString(String value) {
    switch (value) {
      case 'Опоздал':case 'late':
        return late;
      case 'Уважительная причина':case 'validAbsent':
        return validAbsent;
      case 'Неуважительная причина':case 'invalidAbsent':
        return invalidAbsent;
      default:
        throw ArgumentError('Unknown Attendance value: $value');
    }
  }

  @override
  String toString() => value;

  factory Attendance.fromJson(String value) => Attendance.fromString(value);

  String toJson() => value;
}