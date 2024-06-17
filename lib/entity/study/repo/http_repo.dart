import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/study/model/day_study.dart';
import 'package:ratingus_mobile/entity/study/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class HttpStudyRepo extends AbstractStudyRepo {
  final api = GetIt.I<Api>();
  @override
  Future<List<DayStudy>> getByClass(int classId) async {
    try {
      final response = await api.dio.get('/schedule/$classId');
      return (response.data["dayLessons"] as List<dynamic>)
          .map((e) => DayStudy.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}