import 'package:ratingus_mobile/entity/timetable/model/timetable.dart';
import 'package:ratingus_mobile/entity/timetable/model/timetable_entry.dart';

final currentTimetable = Timetable(
    timetableId: 0,
    timetableEntry: [
      TimetableEntry(
          timetableNumber: 1,
          startTime: DateTime.utc(0,0,0, 8, 0),
          endTIme: DateTime.utc(0,0,0, 8, 40)),
      TimetableEntry(
          timetableNumber: 2,
          startTime: DateTime.utc(0,0,0, 8, 50),
          endTIme: DateTime.utc(0,0,0, 9, 30)),
      TimetableEntry(
          timetableNumber: 3,
          startTime: DateTime.utc(0,0,0, 9, 45),
          endTIme: DateTime.utc(0,0,0, 10, 25)),
      TimetableEntry(
          timetableNumber: 4,
          startTime: DateTime.utc(0,0,0, 10, 45),
          endTIme: DateTime.utc(0,0,0, 11, 25)),
      TimetableEntry(
          timetableNumber: 5,
          startTime: DateTime.utc(0,0,0, 11, 40),
          endTIme: DateTime.utc(0,0,0, 12, 20)),
      TimetableEntry(
          timetableNumber: 6,
          startTime: DateTime.utc(0,0,0, 12, 35),
          endTIme: DateTime.utc(0,0,0, 13, 15)),
      TimetableEntry(
          timetableNumber: 7,
          startTime: DateTime.utc(0,0,0, 13, 25),
          endTIme: DateTime.utc(0,0,0, 14, 05)),
      TimetableEntry(
          timetableNumber: 8,
          startTime: DateTime.utc(0,0,0, 14, 15),
          endTIme: DateTime.utc(0,0,0, 14, 55)),
    ]);
