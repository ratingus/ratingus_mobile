import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/user/model/role.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class AnnouncementsTabBar extends StatefulWidget {
  const AnnouncementsTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  _AnnouncementsTabBarState createState() => _AnnouncementsTabBarState();
}

class _AnnouncementsTabBarState extends State<AnnouncementsTabBar> {
  final api = GetIt.I<Api>();

  @override
  void initState() {
    super.initState();
  }

  Future<UserRole> _getRole() async {
    return (await api.decodeToken()).role;
  }

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
    return FutureBuilder<UserRole>(
        future: _getRole().timeout(const Duration(seconds: 10), onTimeout: () {
          throw TimeoutException('Превышено время ожидания');
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Данные не найдены'));
          } else {
            final role = snapshot.data;
            return TabBar(
              controller: widget.tabController,
              labelColor: AppColors.primaryMain,
              unselectedLabelColor: AppColors.textPrimary,
              tabs: [
                _buildTab("Все объявления", 0),
                if (role?.value == UserRole.student.value)
                  _buildTab("Класс", 1),
              ],
            );
          }
        });
  }
}
