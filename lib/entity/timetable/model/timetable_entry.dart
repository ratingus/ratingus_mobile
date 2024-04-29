import 'package:json_annotation/json_annotation.dart';

part 'timetable_entry.g.dart';

@JsonSerializable()
class TimetableEntry {
  final int timetableNumber;
  final DateTime startTime;
  final DateTime endTIme;

  TimetableEntry(
      {required this.timetableNumber,
      required this.startTime,
      required this.endTIme});

  factory TimetableEntry.fromJson(Map<String, dynamic> json) =>
      _$TimetableEntryFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableEntryToJson(this);

  getTime() {
    return '${startTime.hour.toString()}:${startTime.minute.toString().padLeft(2, '0')} - ${endTIme.hour.toString()}:${endTIme.minute.toString().padLeft(2, '0')}';
  }
}
