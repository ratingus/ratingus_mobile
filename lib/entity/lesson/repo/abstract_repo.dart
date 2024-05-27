import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/write_note_dto.dart';

abstract class AbstractLessonRepo {
  Future<List<DayLesson>> getByWeek(DateTime date);

  Future<void> writeNote(WriteNoteDto dto);
  // Future<DayLessonDetail> getByDay(DateTime date);
  // Future<Lesson> getById(DateTime date);
}