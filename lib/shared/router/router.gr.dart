// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AnnouncementsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AnnouncementsPage(),
      );
    },
    CalendarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CalendarPage(),
      );
    },
    DiaryByDayRoute.name: (routeData) {
      final args = routeData.argsAs<DiaryByDayRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DiaryByDayPage(
          key: args.key,
          date: args.date,
        ),
      );
    },
    DiaryByLessonRoute.name: (routeData) {
      final args = routeData.argsAs<DiaryByLessonRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DiaryByLessonPage(
          key: args.key,
          dayLessonDetail: args.dayLessonDetail,
          selectedLesson: args.selectedLesson,
        ),
      );
    },
    DiaryByWeekRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DiaryByWeekPage(),
      );
    },
    DiaryWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DiaryWrapperPage()),
      );
    },
    LayoutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LayoutScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
  };
}

/// generated route for
/// [AnnouncementsPage]
class AnnouncementsRoute extends PageRouteInfo<void> {
  const AnnouncementsRoute({List<PageRouteInfo>? children})
      : super(
          AnnouncementsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnnouncementsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CalendarPage]
class CalendarRoute extends PageRouteInfo<void> {
  const CalendarRoute({List<PageRouteInfo>? children})
      : super(
          CalendarRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalendarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DiaryByDayPage]
class DiaryByDayRoute extends PageRouteInfo<DiaryByDayRouteArgs> {
  DiaryByDayRoute({
    Key? key,
    required DateTime date,
    List<PageRouteInfo>? children,
  }) : super(
          DiaryByDayRoute.name,
          args: DiaryByDayRouteArgs(
            key: key,
            date: date,
          ),
          initialChildren: children,
        );

  static const String name = 'DiaryByDayRoute';

  static const PageInfo<DiaryByDayRouteArgs> page =
      PageInfo<DiaryByDayRouteArgs>(name);
}

class DiaryByDayRouteArgs {
  const DiaryByDayRouteArgs({
    this.key,
    required this.date,
  });

  final Key? key;

  final DateTime date;

  @override
  String toString() {
    return 'DiaryByDayRouteArgs{key: $key, date: $date}';
  }
}

/// generated route for
/// [DiaryByLessonPage]
class DiaryByLessonRoute extends PageRouteInfo<DiaryByLessonRouteArgs> {
  DiaryByLessonRoute({
    Key? key,
    required DateTime dayLessonDetail,
    required int selectedLesson,
    List<PageRouteInfo>? children,
  }) : super(
          DiaryByLessonRoute.name,
          args: DiaryByLessonRouteArgs(
            key: key,
            dayLessonDetail: dayLessonDetail,
            selectedLesson: selectedLesson,
          ),
          initialChildren: children,
        );

  static const String name = 'DiaryByLessonRoute';

  static const PageInfo<DiaryByLessonRouteArgs> page =
      PageInfo<DiaryByLessonRouteArgs>(name);
}

class DiaryByLessonRouteArgs {
  const DiaryByLessonRouteArgs({
    this.key,
    required this.dayLessonDetail,
    required this.selectedLesson,
  });

  final Key? key;

  final DateTime dayLessonDetail;

  final int selectedLesson;

  @override
  String toString() {
    return 'DiaryByLessonRouteArgs{key: $key, dayLessonDetail: $dayLessonDetail, selectedLesson: $selectedLesson}';
  }
}

/// generated route for
/// [DiaryByWeekPage]
class DiaryByWeekRoute extends PageRouteInfo<void> {
  const DiaryByWeekRoute({List<PageRouteInfo>? children})
      : super(
          DiaryByWeekRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiaryByWeekRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DiaryWrapperPage]
class DiaryWrapperRoute extends PageRouteInfo<void> {
  const DiaryWrapperRoute({List<PageRouteInfo>? children})
      : super(
          DiaryWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiaryWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LayoutScreen]
class LayoutRoute extends PageRouteInfo<void> {
  const LayoutRoute({List<PageRouteInfo>? children})
      : super(
          LayoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'LayoutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
