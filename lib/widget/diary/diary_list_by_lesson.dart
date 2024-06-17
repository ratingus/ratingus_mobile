import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/write_note_dto.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/mark/ui/attendance.dart';
import 'package:ratingus_mobile/entity/mark/ui/mark.dart';
import 'package:ratingus_mobile/entity/timetable/mock/timetable.dart';
import 'package:ratingus_mobile/entity/timetable/model/timetable_entry.dart';
import 'package:ratingus_mobile/pages/main/diary/pages/diary_provider.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class DiaryListByLesson extends StatefulWidget {
  final DayLesson dayLessonDetail;
  final int selectedLesson;
  final Future<void> Function() onRefetch;

  const DiaryListByLesson(
      {super.key,
      required this.onRefetch,
      required this.dayLessonDetail,
      required this.selectedLesson});

  @override
  State<DiaryListByLesson> createState() => _DiaryListByLessonState();
}

class _DiaryListByLessonState extends State<DiaryListByLesson> {
  late int selectedLesson;
  late Lesson lesson;
  late TimetableEntry timeTableEntry;
  final diaryRepo = GetIt.I<AbstractLessonRepo>();
  late TextEditingController myController;

  @override
  initState() {
    super.initState();
    selectedLesson = widget.selectedLesson;
    lesson = widget.dayLessonDetail.studies[selectedLesson];
    myController = TextEditingController(text: lesson.note);
    myController.addListener(_updateCounterText);
    timeTableEntry =
        currentTimetable.timetableEntry[lesson.timetableNumber - 1];
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    lesson = widget.dayLessonDetail.studies[selectedLesson];
    myController = TextEditingController(text: lesson.note);
  }

  @override
  void dispose() {
    myController.removeListener(_updateCounterText);
    myController.dispose();
    super.dispose();
  }

  _updateCounterText() {
    setState(() {});
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

  addNote(Lesson lesson) async {
    String value = myController.text;
    if (value != lesson.note) {
      await diaryRepo.writeNote(WriteNoteDto(
          scheduleId: lesson.scheduleId,
          lessonId: lesson.lessonId,
          lessonStudentId: lesson.studentLessonId,
          text: value,
          date: lesson.startTime));

      AppMetrica.reportEvent('Оставлена заметка в дневнике');
    }
  }

  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final dayLesson = diaryProvider.dayLesson;
    final _lesson = diaryProvider.lesson;

    if ((dayLesson?.dateTime != null &&
            isSameDate(dayLesson!.dateTime, widget.dayLessonDetail.dateTime) ==
                false) ||
        (_lesson == null)) {
      diaryProvider.fetchLesson(
          widget.dayLessonDetail.dateTime, selectedLesson);
    }

    Widget renderHomeWork(Lesson lesson) {
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

    Widget renderNote(Lesson lesson) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              maxLines: null,
              maxLength: 1000,
              controller: myController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                border: const OutlineInputBorder().copyWith(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                labelStyle: Theme.of(context).textTheme.displayMedium,
                labelText: 'Заметки',
                hintText: 'Добавьте заметку',
                counterText: '${myController.text.length} / 1000',
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ElevatedButton(
              onPressed: () async {
                await addNote(lesson);
                final l = Lesson(
                  teacher: lesson.teacher,
                    scheduleId: lesson.scheduleId,
                    teacherSubjectId: lesson.teacherSubjectId,
                    subject: lesson.subject,
                    timetableNumber: lesson.timetableNumber,
                    startTime: lesson.startTime,
                    endTime: lesson.endTime,
                    lessonId: lesson.lessonId,
                    studentLessonId: lesson.studentLessonId,
                    homework: lesson.homework,
                    mark: lesson.mark,
                    attendance: lesson.attendance,
                    note: myController.text);
                await diaryProvider.updateLesson(selectedLesson, l);
                myController = TextEditingController(text: l.note);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.primaryMain,
              ),
              child: Text(
                'Сохранить',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: AppColors.primaryPaper),
              ),
            )
          ]);
    }

    return dayLesson != null && _lesson != null
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    capitalize(
                        DateFormat('EEEE', 'ru').format(dayLesson.dateTime)),
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
                  '№${_lesson.timetableNumber.toString()}',
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
                          renderHomeWork(_lesson),
                          markSlot(_lesson),
                        ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  renderNote(_lesson),
                ],
              ),
            ],
          )
        : const Text('Загрузка...');
  }
}
