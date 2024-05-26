import 'package:flutter/foundation.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';

class DiaryProvider with ChangeNotifier {
  final AbstractLessonRepo _lessonRepo;
  List<DayLesson> _dayLessons = [];
  int currentWeek = getAcademicWeekOfYear(DateTime.now());

  DiaryProvider(this._lessonRepo);

  List<DayLesson> get dayLessons => _dayLessons;

  Future<List<DayLesson>> fetchLessons(DateTime dateTime) async {
    int week = getAcademicWeekOfYear(dateTime);
    if (currentWeek != week) {
      _dayLessons = await _lessonRepo.getByWeek(dateTime);
      notifyListeners();
    }
    return _dayLessons;
  }

  Future<DayLesson> fetchLessonsByDay(DateTime dateTime) async {
    int week = getAcademicWeekOfYear(dateTime);
    if (currentWeek != week) {
      _dayLessons = await _lessonRepo.getByWeek(dateTime);
      notifyListeners();
    }
    return _dayLessons.where((element) {
      var day = element.dateTime.day;
      var month = element.dateTime.month;
      var year = element.dateTime.year;

      var day2 =   dateTime.day;
      var month2 = dateTime.month;
      var year2 =  dateTime.year;

      return day == day2 && month == month2 && year == year2;
  }).first;
}

  Future<DayLesson> fetchLesson(DateTime dateTime) async {
    int week = getAcademicWeekOfYear(dateTime);
    if (currentWeek != week) {
      _dayLessons = await _lessonRepo.getByWeek(dateTime);
      notifyListeners();
    }
    return _dayLessons.where((element) {
      var day = element.dateTime.day;
      var month = element.dateTime.month;
      var year = element.dateTime.year;

      var day2 =   dateTime.day;
      var month2 = dateTime.month;
      var year2 =  dateTime.year;

      return day == day2 && month == month2 && year == year2;
    }).first;
  }
}