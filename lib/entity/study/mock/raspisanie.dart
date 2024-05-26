import 'package:ratingus_mobile/entity/study/model/day_study.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/user/model/teacher.dart';

final raspisanie = <DayStudy>[
  DayStudy(
    dayOfWeek: DateTime.monday,
    lessons: [
      Study(
        timetableNumber: 1,
        studyId: 1,
        subject: "Русский язык",
        teacher: Teacher(
            id: 0,
            name: "Ирина",
            surname: "Фёдорова",
            patronymic: "Оскарльдовна"
        ),
        startTime: DateTime(2024, 10, 11, 8, 0),
        endTime: DateTime(2024, 10, 11, 8, 40),
      ),
      Study(
        timetableNumber: 2,
        studyId: 1,
        subject: "Русский язык",
        teacher: Teacher(
            id: 0,
            name: "Ирина",
            surname: "Фёдорова",
            patronymic: "Оскарльдовна"
        ),
        startTime: DateTime(2024, 10, 11, 8, 50),
        endTime: DateTime(2024, 10, 11, 9, 30),
      ),
      Study(
        timetableNumber: 3,
        studyId: 2,
        subject: "Химия",
        teacher: Teacher(
            id: 1,
            name: "Изабелла",
            surname: "Фёдорова",
            patronymic: "Олеговна"
        ),
        startTime: DateTime(2024, 10, 11, 9, 45),
        endTime: DateTime(2024, 10, 11, 10, 25),
      ),
    ]
  ),
  DayStudy(
      dayOfWeek: DateTime.tuesday,
      lessons: [
        Study(
          timetableNumber: 1,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 0),
          endTime: DateTime(2024, 10, 11, 8, 40),
        ),
        Study(
          timetableNumber: 2,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 50),
          endTime: DateTime(2024, 10, 11, 9, 30),
        ),
        Study(
          timetableNumber: 3,
          studyId: 2,
          subject: "Химия",
          teacher: Teacher(
              id: 1,
              name: "Изабелла",
              surname: "Фёдорова",
              patronymic: "Олеговна"
          ),
          startTime: DateTime(2024, 10, 11, 9, 45),
          endTime: DateTime(2024, 10, 11, 10, 25),
        ),
      ]
  ),
  DayStudy(
      dayOfWeek: DateTime.wednesday,
      lessons: [
        Study(
          timetableNumber: 1,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 0),
          endTime: DateTime(2024, 10, 11, 8, 40),
        ),
        Study(
          timetableNumber: 2,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 50),
          endTime: DateTime(2024, 10, 11, 9, 30),
        ),
        Study(
          timetableNumber: 3,
          studyId: 2,
          subject: "Химия",
          teacher: Teacher(
              id: 1,
              name: "Изабелла",
              surname: "Фёдорова",
              patronymic: "Олеговна"
          ),
          startTime: DateTime(2024, 10, 11, 9, 45),
          endTime: DateTime(2024, 10, 11, 10, 25),
        ),
      ]
  ),
  DayStudy(
      dayOfWeek: DateTime.thursday,
      lessons: [
        Study(
          timetableNumber: 1,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 0),
          endTime: DateTime(2024, 10, 11, 8, 40),
        ),
        Study(
          timetableNumber: 2,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 50),
          endTime: DateTime(2024, 10, 11, 9, 30),
        ),
        Study(
          timetableNumber: 3,
          studyId: 2,
          subject: "Химия",
          teacher: Teacher(
              id: 1,
              name: "Изабелла",
              surname: "Фёдорова",
              patronymic: "Олеговна"
          ),
          startTime: DateTime(2024, 10, 11, 9, 45),
          endTime: DateTime(2024, 10, 11, 10, 25),
        ),
      ]
  ),
  DayStudy(
      dayOfWeek: DateTime.friday,
      lessons: [
        Study(
          timetableNumber: 1,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 0),
          endTime: DateTime(2024, 10, 11, 8, 40),
        ),
        Study(
          timetableNumber: 2,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 50),
          endTime: DateTime(2024, 10, 11, 9, 30),
        ),
        Study(
          timetableNumber: 3,
          studyId: 2,
          subject: "Химия",
          teacher: Teacher(
              id: 1,
              name: "Изабелла",
              surname: "Фёдорова",
              patronymic: "Олеговна"
          ),
          startTime: DateTime(2024, 10, 11, 9, 45),
          endTime: DateTime(2024, 10, 11, 10, 25),
        ),
      ]
  ),
  DayStudy(
      dayOfWeek: DateTime.saturday,
      lessons: [
        Study(
          timetableNumber: 1,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 0),
          endTime: DateTime(2024, 10, 11, 8, 40),
        ),
        Study(
          timetableNumber: 2,
          studyId: 1,
          subject: "Русский язык",
          teacher: Teacher(
              id: 0,
              name: "Ирина",
              surname: "Фёдорова",
              patronymic: "Оскарльдовна"
          ),
          startTime: DateTime(2024, 10, 11, 8, 50),
          endTime: DateTime(2024, 10, 11, 9, 30),
        ),
        Study(
          timetableNumber: 3,
          studyId: 2,
          subject: "Химия",
          teacher: Teacher(
              id: 1,
              name: "Изабелла",
              surname: "Фёдорова",
              patronymic: "Олеговна"
          ),
          startTime: DateTime(2024, 10, 11, 9, 45),
          endTime: DateTime(2024, 10, 11, 10, 25),
        ),
      ]
  ),
];