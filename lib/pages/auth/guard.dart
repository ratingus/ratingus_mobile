import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';
import 'package:ratingus_mobile/shared/router/router.dart';

class AuthGuard extends AutoRouteGuard {
  final api = GetIt.I<Api>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    api.isTokenExpired().then((isExpired) {
      if (isExpired) {
        resolver.redirect(const LoginRoute());
      } else {
        resolver.next(true);
      }
    }).catchError((_) {
      resolver.redirect(const LoginRoute());
    });
  }
}