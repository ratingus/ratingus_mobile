import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/user/model/edit_profile_dto.dart';
import 'package:ratingus_mobile/entity/user/model/profile_dto.dart';
import 'package:ratingus_mobile/entity/user/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class HttpProfileRepo extends AbstractProfileRepo {
  final api = GetIt.I<Api>();

  @override
  Future<void> changeSchool(int schoolId) async {
    try {
      debugPrint("schoolId: $schoolId");
      await api.dio.post('/profile/change-school', data: { 'id': schoolId });
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  @override
  Future<ProfileDto> getProfile() async {
    try {
      final response = await api.dio.get('/profile');
      return ProfileDto.fromJson(response.data);
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> enterCode(String code) async {
    try {
      await api.dio.post('/profile/user-code', data: { "code": code });
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> editProfile(EditProfileDto editProfileDto) async {
    try {
      debugPrint(editProfileDto.toString());
      await api.dio.put('/profile', data: {
        "name": editProfileDto.name,
        "surname": editProfileDto.surname,
        "patronymic": editProfileDto.patronymic,
        "birthDate": editProfileDto.birthDate,
      });
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }
}