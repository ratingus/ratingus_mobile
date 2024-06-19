import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/mark/ui/attendance.dart';
import 'package:ratingus_mobile/entity/mark/ui/mark.dart';
import 'package:ratingus_mobile/entity/study/ui/study_item.dart';
import 'package:ratingus_mobile/pages/main/diary/pages/diary_provider.dart';
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
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final dayLessons = diaryProvider.dayLessons;

    return dayLessons != null ? StudyListView<DayLesson, Lesson>(
      list: dayLessons,
      renderDay: (currentDay) => TextButton(
          onPressed: () {
            diaryProvider.fetchLessonsByDay(currentDay.dateTime);
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
                getDayMonth(currentDay.dateTime, true),
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
          )),
      renderItem: (lesson, day, index) => TextButton(
          onPressed: () {
            diaryProvider.fetchLesson(day.dateTime, day.studies.indexOf(lesson));
            AutoRouter.of(context).push(DiaryByLessonRoute(
                day: day,
                selectedLesson: day.studies.indexOf(lesson),
                onRefetch: () async {
                  diaryProvider
                       .fetchLesson(day.dateTime, day.studies.indexOf(lesson));
                }));
          },
          child:
              StudyItem(study: lesson, rightSlot: markSlot(lesson))),
    ) : const Text("Нет расписания");
  }
}
