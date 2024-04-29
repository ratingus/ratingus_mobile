import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/mark/ui/attendance.dart';
import 'package:ratingus_mobile/entity/mark/ui/mark.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/study/ui/study_item.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/widget/study/study_list_view.dart';

class DiaryListByWeek extends StatelessWidget {
  final List<DayLesson> lessonList;

  const DiaryListByWeek({super.key, required this.lessonList});

  markSlot(Lesson lesson) {
    if (lesson.mark != null) {
      return LessonMark(
        mark: lesson.mark!,
      );
    }
    if (lesson.attendance != null) {
      return AttendanceMark(attendance: lesson.attendance!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StudyListView<DayLesson, Lesson>(
      list: lessonList,
      renderDay: (currentDay) => TextButton(
          onPressed: () {
            AutoRouter.of(context)
                .push(DiaryByDayRoute(date: currentDay.dateTime));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                capitalize(DateFormat('EEEE', 'ru')
                    .format(getDayOfWeek(currentDay.dateTime.weekday))),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                getDayMonth(currentDay.dateTime),
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
          )),
      renderItem: (lesson, day) => TextButton(
          onPressed: () {
            AutoRouter.of(context).push(DiaryByLessonRoute(
                dayLessonDetail: day.dateTime, selectedLesson: lesson.timetableNumber - 1));
          },
          child:
              StudyItem(study: lesson as Study, rightSlot: markSlot(lesson))),
    );
  }
}