import 'package:flutter/foundation.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';

class DiaryProvider with ChangeNotifier {
  final AbstractLessonRepo _lessonRepo;

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

  Future<void> fetchDayLessons(DateTime dateTime) async {
    _isDayLessonsLoading = true;
    notifyListeners();
    try {
      _dayLessons = await _lessonRepo.getByWeek(dateTime);
    } catch (e) {
      _dayLessons = null;
    } finally {
      _isDayLessonsLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLessonsByDay(DateTime dateTime) async {
    _isDayLessonLoading = true;
    notifyListeners();
    try {
      await fetchDayLessons(dateTime);
      print(dateTime);

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
    } catch (e) {
      _dayLesson = null;
    }
    _isDayLessonLoading = false;
    notifyListeners();
  }

  Future<void> fetchLesson(DateTime date, int lessonNumber) async {
    var dateTime = date.add(const Duration(minutes: 1));
    _isLessonLoading = true;
    notifyListeners();
    try {
      if (_dayLesson == null) {
        await fetchLessonsByDay(dateTime);
      }
      if ((dayLesson?.dateTime != null && isSameDate(dayLesson!.dateTime, date) == false)) {
        await fetchLessonsByDay(dateTime);
      }
      _lesson = _dayLesson!.studies[lessonNumber];
    } catch (e) {
      _lesson = null;
    }
    _isLessonLoading = false;
    notifyListeners();
  }

  Future<void> updateLesson(int lessonNumber, Lesson lesson) async {
    notifyListeners();
    try {
      if (_dayLesson?.studies != null) {
        _dayLesson!.studies[lessonNumber] = lesson;
      }
    } catch (e) {
      _lesson = null;
    }
    notifyListeners();
  }
}
