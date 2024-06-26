import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/write_note_dto.dart';
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
      debugPrint('Response: ${response.data}');
      return (response.data as List<dynamic>)
          .map((e) => DayLesson.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> writeNote(WriteNoteDto dto) async {
    try {
      await api.dio.post('/diary/lesson', data: dto.toJson());
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

}