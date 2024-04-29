import 'package:auto_route/auto_route.dart';
import 'package:ratingus_mobile/shared/router/router.dart';

abstract class AuthRoutes {
  static final routes = AutoRoute(
    page: AuthWrapperRoute.page,
    path: '/auth',
    children: [
      AutoRoute(page: LoginRoute.page, path: 'login', initial: true),
      AutoRoute(page: RegistrationRoute.page, path: 'registration'),
    ],
  );
}
