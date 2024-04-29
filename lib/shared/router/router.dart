import 'package:auto_route/auto_route.dart';
import 'package:ratingus_mobile/pages/main/announcements.dart';
import 'package:ratingus_mobile/pages/auth/guard.dart';
import 'package:ratingus_mobile/pages/auth/layout.dart';
import 'package:ratingus_mobile/pages/auth/pages/login.dart';
import 'package:ratingus_mobile/pages/auth/pages/registration.dart';
import 'package:ratingus_mobile/pages/auth/routes.dart';
import 'package:ratingus_mobile/pages/main/calendar.dart';
import 'package:ratingus_mobile/pages/diary/layout.dart';
import 'package:ratingus_mobile/pages/diary/pages/by_day.dart';
import 'package:ratingus_mobile/pages/diary/pages/by_lesson.dart';
import 'package:ratingus_mobile/pages/diary/pages/by_week.dart';
import 'package:ratingus_mobile/pages/diary/routes.dart';
import 'package:ratingus_mobile/pages/main/layout.dart';
import 'package:ratingus_mobile/pages/main/profile.dart';
import 'package:flutter/foundation.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LayoutRoute.page,
          initial: true,
          guards: [AuthGuard()],
          children: [
            AutoRoute(
                page: AnnouncementsRoute.page,
                path: 'announcements',
                initial: true),
            DiaryRoutes.routes,
            AutoRoute(page: CalendarRoute.page, path: 'calendar'),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
          ],
        ),
        AuthRoutes.routes,
      ];
}
