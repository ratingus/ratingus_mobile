import 'package:ratingus_mobile/entity/lesson/mock/diary.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/shared/utils/connection_simulator.dart';

import 'abstract_repo.dart';

class MockLessonRepo extends AbstractLessonRepo {
  @override
  Future<DayLesson> getByDay(DateTime date) {
    return ConnectionSimulator<DayLesson>().connect(() {
      return getCurrentDayDiary(date);
    });
  }

  @override
  Future<Lesson> getById(DateTime date) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<DayLesson>> getByWeek(DateTime date) {
    return ConnectionSimulator<List<DayLesson>>().connect(() {
      return getCurrentWeekDiary(date);
    });
  }

}