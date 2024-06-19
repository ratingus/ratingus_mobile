import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/mark/model/attendance.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';

import 'mark.dart';

class AttendanceMark extends StatelessWidget {
  final Attendance attendance;

  const AttendanceMark({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Посещаемость: ',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        LessonMark(
          mark: capitalize(attendance.toString()).substring(0, 1),
        )
      ],
    );
  }
}
