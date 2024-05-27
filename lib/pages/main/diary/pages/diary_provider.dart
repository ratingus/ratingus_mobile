import 'package:flutter/foundation.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';

class DiaryProvider with ChangeNotifier {
  final AbstractLessonRepo _lessonRepo;
  int currentWeek = getAcademicWeekOfYear(DateTime.now());

  List<DayLesson>? _dayLessons;
  bool _isDayLessonsLoading = false;

  DayLesson? _dayLesson;
  bool _isDayLessonLoading = false;

  Lesson? _lesson;
  bool _isLessonLoading = false;


  DiaryProvider(this._lessonRepo);

  List<DayLesson>? get dayLessons => _dayLessons;
  bool get isDayLessonsLoading => _isDayLessonsLoading;

  DayLesson? get dayLesson => _dayLesson;
  bool get isDayLessonLoading => _isDayLessonLoading;

  Lesson? get lesson => _lesson;
  bool get isLessonLoading => _isLessonLoading;

  Future<void> fetchLessons(DateTime dateTime) async {
    int week = getAcademicWeekOfYear(dateTime);
    if (currentWeek != week) {
      _isDayLessonsLoading = true;
      notifyListeners();
      try {
        _dayLessons = await _lessonRepo.getByWeek(dateTime);
      } catch (e) {
        _dayLessons = null;
      }
      _isDayLessonsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLessonsByDay(DateTime dateTime) async {
    int week = getAcademicWeekOfYear(dateTime);
    if (currentWeek != week) {
      _isDayLessonLoading = true;
      notifyListeners();
      _dayLessons = await _lessonRepo.getByWeek(dateTime);

      if (_dayLessons == null) {
        _dayLesson = null;
      } else {
        _dayLesson = _dayLessons!.where((element) {
          var day = element.dateTime.day;
          var month = element.dateTime.month;
          var year = element.dateTime.year;

          var day2 = dateTime.day;
          var month2 = dateTime.month;
          var year2 = dateTime.year;

          return day == day2 && month == month2 && year == year2;
        }).first;
      }
      _isDayLessonLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLesson(DateTime dateTime) async {
    int week = getAcademicWeekOfYear(dateTime);
    if (currentWeek != week) {
      _isLessonLoading = false;
      notifyListeners();
      _dayLessons = await _lessonRepo.getByWeek(dateTime);
      notifyListeners();
    }
    if (_dayLessons == null) {
      _lesson = null;
    } else {
      _dayLesson = _dayLessons!.where((element) {
        var day = element.dateTime.day;
        var month = element.dateTime.month;
        var year = element.dateTime.year;

        var day2 = dateTime.day;
        var month2 = dateTime.month;
        var year2 = dateTime.year;

        return day == day2 && month == month2 && year == year2;
      }).first;
    }
    if (_dayLesson != null) {
      _lesson = _dayLesson!.lessons.first;
    } else {
      _lesson = null;
    }
    _isLessonLoading = false;
  }
}
