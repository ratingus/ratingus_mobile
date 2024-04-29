import 'package:auto_route/auto_route.dart';
import 'package:ratingus_mobile/shared/router/router.dart';

import 'layout.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (isAuthorized) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
