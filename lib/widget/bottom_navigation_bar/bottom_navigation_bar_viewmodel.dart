import 'package:flutter/cupertino.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/user/model/role.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class BottomNavigationBarViewModel {
  final TokenNotifier _tokenNotifier;
  final Api api;
  ValueNotifier<UserRole> _role = ValueNotifier(UserRole.guest);

  BottomNavigationBarViewModel(this._tokenNotifier, this.api) {
    _tokenNotifier.addListener(_onTokenChanged);
    api.decodeToken().then((jwt) => {
      _role.value = jwt.role,
      _tokenNotifier.refreshToken()
    });
  }

  void dispose() {
    _tokenNotifier.removeListener(_onTokenChanged);
  }

  void _onTokenChanged() {
    api.decodeToken().then((jwt) {
      _role.value = jwt.role;
    });
  }

  ValueNotifier<UserRole> get role => _role;
}