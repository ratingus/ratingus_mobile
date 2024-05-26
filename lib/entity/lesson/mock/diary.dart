// import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
// import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
// import 'package:ratingus_mobile/entity/mark/model/attendance.dart';
// import 'package:ratingus_mobile/entity/user/model/teacher.dart';
//
// String getMark(DateTime date, {int offset = 0}) {
//   int day = date.day + offset;
//
//   if (day % 4 == 0) {
//     return "2";
//   } else if (day % 3 == 0) {
//     return "3";
//   } else if (day.isEven) {
//     return "5";
//   } else {
//     return "4";
//   }
// }
//
// getCurrentDayDiary(DateTime day) {
//   DayLesson dayLesson = getCurrentWeekDiary(day)[day.weekday - 1];
//
//   return DayLesson(
//     dateTime: dayLesson.dateTime,
//     lessons: dayLesson.lessons
//         .map((lesson) => Lesson(
//               id: lesson.lessonId,
//               studyId: lesson.studentLessonId,
//               timetableNumber: lesson.timetableNumber,
//               subject: lesson.subject,
//               teacher: lesson.teacher,
//               mark: lesson.mark,
//               attendance: lesson.attendance,
//               homework: "Домашнее задание",
//               note: dayLesson.dateTime.weekday == 2 && lesson.subject == 'Химия'
//                   ? "Заметка о предмете, которую написал я, чтобы не забыть положить краски в портфель за несколько дней до урока и не будить родителей в три ночи, когда я буду нуждаться в красках больше всего"
//                   : null, scheduleId: lesson.scheduleId, teacherSubjectId: lesson.teacherSubjectId,
//             ))
//         .toList(), dayOfWeek: day.weekday - 1,
//   );
// }
//
// getCurrentWeekDiary(DateTime date) {
//   var weekStart = date.subtract(Duration(days: date.weekday - 1));
//
//   return <DayLesson>[
//     DayLesson(dateTime: weekStart, lessons: [
//       Lesson(
//         timetableNumber: 1,
//         studyId: 1,
//         subject: "Русский язык",
//         mark: getMark(weekStart).toString(),
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 0,
//       ),
//       Lesson(
//         timetableNumber: 2,
//         studyId: 1,
//         subject: "Русский язык",
//         attendance: Attendance.invalidAbsent,
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 1,
//       ),
//       Lesson(
//         timetableNumber: 3,
//         studyId: 2,
//         subject: "Химия",
//         mark: getMark(weekStart, offset: 1).toString(),
//         teacher: Teacher(
//             id: 1,
//             name: "Изабелла",
//             surname: "Фёдорова",
//             patronymic: "Олеговна"),
//         id: 2,
//       ),
//     ], dayOfWeek: null),
//     DayLesson(dateTime: weekStart.add(const Duration(days: 1)), lessons: [
//       Lesson(
//         timetableNumber: 1,
//         studyId: 1,
//         subject: "Русский язык",
//         attendance: Attendance.validAbsent,
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 3,
//       ),
//       Lesson(
//         timetableNumber: 2,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 4,
//       ),
//       Lesson(
//         timetableNumber: 3,
//         studyId: 2,
//         subject: "Химия",
//         teacher: Teacher(
//             id: 1,
//             name: "Изабелла",
//             surname: "Фёдорова",
//             patronymic: "Олеговна"),
//         id: 5,
//       ),
//     ]),
//     DayLesson(dateTime: weekStart.add(const Duration(days: 2)), lessons: [
//       Lesson(
//         timetableNumber: 1,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 6,
//       ),
//       Lesson(
//         timetableNumber: 2,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 7,
//       ),
//       Lesson(
//         timetableNumber: 3,
//         studyId: 2,
//         subject: "Химия",
//         teacher: Teacher(
//             id: 1,
//             name: "Изабелла",
//             surname: "Фёдорова",
//             patronymic: "Олеговна"),
//         id: 8,
//       ),
//     ]),
//     DayLesson(dateTime: weekStart.add(const Duration(days: 3)), lessons: [
//       Lesson(
//         timetableNumber: 1,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 9,
//       ),
//       Lesson(
//         timetableNumber: 2,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 10,
//       ),
//       Lesson(
//         timetableNumber: 3,
//         studyId: 2,
//         subject: "Химия",
//         teacher: Teacher(
//             id: 1,
//             name: "Изабелла",
//             surname: "Фёдорова",
//             patronymic: "Олеговна"),
//         id: 11,
//       ),
//     ]),
//     DayLesson(dateTime: weekStart.add(const Duration(days: 4)), lessons: [
//       Lesson(
//         timetableNumber: 1,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 12,
//       ),
//       Lesson(
//         timetableNumber: 2,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 13,
//       ),
//       Lesson(
//         timetableNumber: 3,
//         studyId: 2,
//         subject: "Химия",
//         teacher: Teacher(
//             id: 1,
//             name: "Изабелла",
//             surname: "Фёдорова",
//             patronymic: "Олеговна"),
//         id: 14,
//       ),
//     ]),
//     DayLesson(dateTime: weekStart.add(const Duration(days: 5)), lessons: [
//       Lesson(
//         timetableNumber: 1,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 15,
//       ),
//       Lesson(
//         timetableNumber: 2,
//         studyId: 1,
//         subject: "Русский язык",
//         teacher: Teacher(
//             id: 0,
//             name: "Ирина",
//             surname: "Фёдорова",
//             patronymic: "Оскарльдовна"),
//         id: 16,
//       ),
//       Lesson(
//         timetableNumber: 3,
//         studyId: 2,
//         subject: "Химия",
//         teacher: Teacher(
//             id: 1,
//             name: "Изабелла",
//             surname: "Фёдорова",
//             patronymic: "Олеговна"),
//         id: 17,
//       ),
//     ])
//   ];
// }
