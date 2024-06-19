import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/mark/ui/attendance.dart';
import 'package:ratingus_mobile/entity/mark/ui/mark.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/study/ui/study_item.dart';
import 'package:ratingus_mobile/pages/main/diary/pages/diary_provider.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/widget/study/study_list_view.dart';

class DiaryListByDay extends StatefulWidget {
  final List<DayLesson> lessonList;

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
    Widget renderHomeWork(Lesson lesson) {
      if (lesson.homework != null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Домашнее задание:",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 4,),
            Text(
              lesson.homework!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        );
      }
      return const SizedBox(
        height: 0,
      );
    }

    Widget renderNote(Lesson lesson) {
      if (lesson.note != null) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Заметки:",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 4,),
              Text(
                lesson.note!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ]);
      }
      return const SizedBox(
        height: 0,
      );
    }
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final dayLesson = diaryProvider.dayLesson;

    return dayLesson != null ? StudyListView<DayLesson, Lesson>(
      list: [dayLesson],
      renderItem: (lesson, day, _) => TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(0))),
          onPressed: ()  {
            AutoRouter.of(context).push(DiaryByLessonRoute(
                selectedLesson: day.studies.indexOf(lesson),
                day: day,
              onRefetch: () async {
                diaryProvider
                    .fetchLessonsByDay(day.dateTime);
              }
            ));
          },
          child: StudyItem(
            study: lesson as Study,
            rightSlot: markSlot(lesson),
            bottomSlot: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                renderHomeWork(lesson),
                if (lesson.homework != null || lesson.note != null)
                const SizedBox(height: 8,),
                renderNote(lesson),
              ],
            ),
          )),
    ) : const Text("Загрузка...");
  }
}
