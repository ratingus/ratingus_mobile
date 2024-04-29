import 'package:json_annotation/json_annotation.dart';

import 'timetable_entry.dart';

part 'timetable.g.dart';

@JsonSerializable()
class Timetable {
  final int timetableId;
  final List<TimetableEntry> timetableEntry;

  Timetable({required this.timetableId, required this.timetableEntry});

  factory Timetable.fromJson(Map<String, dynamic> json) =>
      _$TimetableFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableToJson(this);
}
