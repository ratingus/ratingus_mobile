import 'package:auto_route/auto_route.dart';
import 'package:ratingus_mobile/pages/announcements_page.dart';
import 'package:ratingus_mobile/pages/profile_page.dart';

import 'layout.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LayoutRoute.page,
          initial: true,
          children: [
            AutoRoute(page: AnnouncementsRoute.page, path: 'announcements', initial: true),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
          ],
        )
      ];
}