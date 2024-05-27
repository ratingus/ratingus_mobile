import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/user/model/profile_dto.dart';
import 'package:ratingus_mobile/entity/user/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class HttpProfileRepo extends AbstractProfileRepo {
  final api = GetIt.I<Api>();

  @override
  Future<void> changeSchool(int schoolId) async {
    try {
      print("schoolId: $schoolId");
      await api.dio.post('/profile/change-school', data: { 'id': schoolId });
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProfileDto> getProfile(int userId) async {
    try {
      final response = await api.dio.get('/profile/$userId');
      print(response.data);
      return ProfileDto.fromJson(response.data);
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> enterCode(String code) async {
    try {
      await api.dio.post('/profile/user-code', data: { "code": code });
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}