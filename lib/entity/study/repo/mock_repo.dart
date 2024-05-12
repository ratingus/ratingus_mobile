import 'package:ratingus_mobile/entity/study/mock/raspisanie.dart';
import 'package:ratingus_mobile/entity/study/model/day_study.dart';
import 'package:ratingus_mobile/entity/study/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/utils/connection_simulator.dart';

class MockStudyRepo extends AbstractStudyRepo {
  @override
  Future<List<DayStudy>> getByClass(int classId) {
    return ConnectionSimulator<List<DayStudy>>().connect(() {
      return raspisanie;
    });
  }

}