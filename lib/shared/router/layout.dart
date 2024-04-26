import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/shared/theme/theme.dart';
import 'package:ratingus_mobile/widget/bottom_navigation_bar/bottom_navigation_bar.dart';

@RoutePage()
class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ratingus',
        theme: appThemeData,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: AutoTabsScaffold(
          routes: const [
            AnnouncementsRoute(),
            ProfileRoute(),
            // TODO: routes
          ],
          bottomNavigationBuilder: (_, tabsRouter) =>
              RatingusBottomNavigationBar(onTap: tabsRouter.setActiveIndex),
        ));
  }
}
