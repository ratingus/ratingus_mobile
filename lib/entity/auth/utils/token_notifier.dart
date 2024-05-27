import 'package:flutter/widgets.dart';
import 'package:ratingus_mobile/entity/user/model/jwt.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class TokenNotifier extends ValueNotifier<JWT?> {
  final Api api;

  TokenNotifier(this.api) : super(null) {
    _loadToken();
  }

  Future<void> _loadToken() async {
    try {
      value = await api.decodeToken();
    } catch (e) {
      // Обработка ошибок
    }
  }

  Future<void> refreshToken() async {
    _loadToken();
  }
}