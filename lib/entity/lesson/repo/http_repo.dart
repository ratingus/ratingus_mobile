import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';

import 'abstract_repo.dart';

class HttpLessonRepo extends AbstractLessonRepo {
  final api = GetIt.I<Api>();

  @override
  Future<List<DayLesson>> getByWeek(DateTime date) async {
    int week = getAcademicWeekOfYear(date);
    try {
      final response = await api.dio.get('/diary/week?week=$week');
      print('Response: ${response.data}');
      return response.data;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

}