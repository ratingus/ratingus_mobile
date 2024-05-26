import 'package:ratingus_mobile/entity/auth/model/user_login.dart';
import 'package:ratingus_mobile/entity/auth/model/user_register.dart';

abstract class AbstractAuthRepo {
  Future<void> login(UserLogin userLogin);
  Future<void> register(UserRegister userRegister);
}