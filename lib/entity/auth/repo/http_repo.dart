import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/auth/model/user_login.dart';
import 'package:ratingus_mobile/entity/auth/model/user_register.dart';
import 'package:ratingus_mobile/entity/auth/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class HttpAuthRepo extends AbstractAuthRepo {
  final api = GetIt.I<Api>();

  @override
  Future<void> login(UserLogin userLogin) async {
    try {
      final response = await api.dio.post('/auth/login', data: userLogin.toJson());
      print('Response: ${response.data}');
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  @override
  Future<void> register(UserRegister userRegister) async {
    try {
      final response = await api.dio.post('/auth/register', data: userRegister.toJson());
      print('Response: ${response.data}');
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

}