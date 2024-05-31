import 'package:ratingus_mobile/entity/user/model/profile_dto.dart';

abstract class AbstractProfileRepo {
  Future<ProfileDto> getProfile();
  Future<void> changeSchool(int schoolId);
  Future<void> enterCode(String code);
}