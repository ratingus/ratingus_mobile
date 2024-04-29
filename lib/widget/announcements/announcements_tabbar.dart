import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class AnnouncementsTabBar extends StatefulWidget {
  const AnnouncementsTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  _AnnouncementsTabBarState createState() => _AnnouncementsTabBarState();
}

class _AnnouncementsTabBarState extends State<AnnouncementsTabBar> {
  Widget _buildTab(String title, int index) {
    return Tab(
      child: AnimatedBuilder(
        animation: widget.tabController,
        builder: (BuildContext context, _) {
          final textTheme = Theme.of(context).textTheme.headlineSmall;
          return Text(
            title,
            style: widget.tabController.index == index
                ? textTheme?.copyWith(color: AppColors.primaryMain)
                : textTheme,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: widget.tabController,
      labelColor: AppColors.primaryMain,
      unselectedLabelColor: AppColors.textPrimary,
      tabs: [
        _buildTab("Все объявления", 0),
        _buildTab("Класс", 1),
      ],
    );
  }
}
