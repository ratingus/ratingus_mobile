import 'package:auto_route/auto_route.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson_detail.dart';
import 'package:ratingus_mobile/pages/announcements.dart';
import 'package:ratingus_mobile/pages/calendar.dart';
import 'package:ratingus_mobile/pages/diary/layout.dart';
import 'package:ratingus_mobile/pages/diary/pages/by_day.dart';
import 'package:ratingus_mobile/pages/diary/pages/by_lesson.dart';
import 'package:ratingus_mobile/pages/diary/pages/by_week.dart';
import 'package:ratingus_mobile/pages/diary/routes.dart';
import 'package:ratingus_mobile/pages/profile.dart';
import 'package:flutter/foundation.dart';

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
            AutoRoute(page: AnnouncementsRoute.page, path: 'announcements'),
            DiaryRoutes.routes,
            AutoRoute(page: CalendarRoute.page, path: 'calendar'),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
          ],
        )
      ];
}
