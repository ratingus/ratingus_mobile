import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';

abstract class AbstractLessonRepo {
  Future<List<DayLesson>> getByWeek(DateTime date);
  // Future<DayLessonDetail> getByDay(DateTime date);
  // Future<Lesson> getById(DateTime date);
}