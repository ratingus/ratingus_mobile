import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson_detail.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson_detail.dart';
import 'package:ratingus_mobile/entity/mark/ui/attendance.dart';
import 'package:ratingus_mobile/entity/mark/ui/mark.dart';
import 'package:ratingus_mobile/entity/timetable/mock/timetable.dart';
import 'package:ratingus_mobile/entity/timetable/model/timetable_entry.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class DiaryListByLesson extends StatefulWidget {
  final DayLessonDetail dayLessonDetail;
  final int selectedLesson;

  const DiaryListByLesson(
      {super.key, required this.dayLessonDetail, required this.selectedLesson});

  @override
  State<DiaryListByLesson> createState() => _DiaryListByLessonState();
}

class _DiaryListByLessonState extends State<DiaryListByLesson> {
  late int selectedLesson;
  late LessonDetail lesson;
  late TimetableEntry timeTableEntry;

  @override
  initState() {
    super.initState();
    selectedLesson = widget.selectedLesson;
    lesson = widget.dayLessonDetail.studies[selectedLesson];
    timeTableEntry =
        currentTimetable.timetableEntry[lesson.timetableNumber - 1];
  }

  markSlot(Lesson lesson) {
    if (lesson.mark != null) {
      return LessonMark(
        mark: lesson.mark!,
      );
    }
    if (lesson.attendance != null) {
      return AttendanceMark(attendance: lesson.attendance!);
    }
    return const SizedBox();
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
              'Д/з',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              lesson.homework!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        );
      }
      return const SizedBox(
        height: 0,
      );
    }

    Widget renderNote(LessonDetail lesson) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              maxLines: null,
              initialValue: lesson.note,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                border: const OutlineInputBorder().copyWith(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                labelStyle: Theme.of(context).textTheme.displayMedium,
                labelText: 'Заметки',
                hintText: 'Добавьте заметку',
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ]);
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              capitalize(DateFormat('EEEE', 'ru')
                  .format(widget.dayLessonDetail.dateTime)),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.textHelper),
            ),
            Text(
              getDayMonth(widget.dayLessonDetail.dateTime),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.textHelper),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '№${lesson.timetableNumber.toString()}',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            timeTableEntry.getTime(),
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ]),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Divider(
            height: 1,
            color: AppColors.textPrimary,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    renderHomeWork(lesson),
                    markSlot(lesson),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            renderNote(lesson),
          ],
        ),
      ],
    );
  }
}
