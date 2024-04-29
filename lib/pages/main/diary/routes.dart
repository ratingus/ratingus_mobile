import 'package:auto_route/auto_route.dart';
import 'package:ratingus_mobile/shared/router/router.dart';

abstract class DiaryRoutes {
  static final routes = AutoRoute(
    page: DiaryWrapperRoute.page,
    path: 'diary',
    children: [
      AutoRoute(page: DiaryByWeekRoute.page, path: 'week', initial: true),
      AutoRoute(page: DiaryByDayRoute.page, path: 'day'),
      AutoRoute(page: DiaryByLessonRoute.page, path: 'lesson'),
    ],
  );
}