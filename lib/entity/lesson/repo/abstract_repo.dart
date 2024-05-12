import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson_detail.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';

abstract class AbstractLessonRepo {
  Future<List<DayLesson>> getByWeek(DateTime date);
  Future<DayLessonDetail> getByDay(DateTime date);
  Future<Lesson> getById(DateTime date);
}