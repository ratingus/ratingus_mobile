import 'package:ratingus_mobile/entity/study/model/day_study.dart';

abstract class AbstractStudyRepo {
  Future<List<DayStudy>> getByClass(int classId);
}