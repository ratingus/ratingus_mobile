import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson_detail.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson_detail.dart';
import 'package:ratingus_mobile/entity/mark/ui/attendance.dart';
import 'package:ratingus_mobile/entity/mark/ui/mark.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/study/ui/study_item.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/widget/study/study_list_view.dart';

class DiaryListByDay extends StatefulWidget {
  final List<DayLessonDetail> lessonList;

  const DiaryListByDay({super.key, required this.lessonList});

  @override
  State<DiaryListByDay> createState() => _DiaryListByDayState();
}

class _DiaryListByDayState extends State<DiaryListByDay> {
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
    Widget renderHomeWork(LessonDetail lesson) {
      if (lesson.homework != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Домашнее задание:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              lesson.homework!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      }
      return const SizedBox(
        height: 0,
      );
    }

    Widget renderNote(LessonDetail lesson) {
      if (lesson.note != null) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Заметки:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                lesson.note!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ]);
      }
      return const SizedBox(
        height: 0,
      );
    }

    return StudyListView<DayLessonDetail, LessonDetail>(
      list: widget.lessonList,
      renderItem: (lesson, day) => TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(0))),
          onPressed: () {
            AutoRouter.of(context).push(DiaryByLessonRoute(
                selectedLesson: lesson.timetableNumber - 1,
                dayLessonDetail: widget.lessonList[0].dateTime));
          },
          child: StudyItem(
            study: lesson as Study,
            rightSlot: markSlot(lesson),
            bottomSlot: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                renderHomeWork(lesson),
                renderNote(lesson),
              ],
            ),
          )),
    );
  }
}