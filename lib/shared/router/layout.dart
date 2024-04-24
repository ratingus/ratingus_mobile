import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/widget/bottom_navigation_bar/bottom_navigation_bar.dart';

@RoutePage()
class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        AnnouncementsRoute(),
        ProfileRoute(),
        // TODO: routes
      ],
      bottomNavigationBuilder: (_, tabsRouter) =>
          RatingusBottomNavigationBar(onTap: tabsRouter.setActiveIndex),
    );
  }
}
