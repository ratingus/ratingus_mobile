import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/user/model/role.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/widget/announcements/announcements_listview_all.dart';
import 'package:ratingus_mobile/widget/announcements/announcements_listview_by_class.dart';
import 'package:ratingus_mobile/widget/announcements/announcements_tabbar.dart';

@RoutePage()
class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage>
    with SingleTickerProviderStateMixin {
  late final TokenNotifier _tokenNotifier;
  late TabController _tabController;
  final api = GetIt.I<Api>();
  late UserRole? role;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tokenNotifier = GetIt.I<TokenNotifier>();
    _tokenNotifier.addListener(_onTokenChanged);
    _initialize();
  }

  void _onTokenChanged() async {
    isLoading = true;
    setState(() {});
    try {
      role = (await api.decodeToken()).role;
      _tabController =
          TabController(length: role == UserRole.student ? 2 : 1, vsync: this);
    } catch (error) {
    } finally {
      isLoading = false;
    }
    setState(() {});
  }

  void _initialize() async {
    isLoading = true;
    setState(() {});
    try {
      role = (await api.decodeToken()).role;
      _tabController =
          TabController(length: role == UserRole.student ? 2 : 1, vsync: this);
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _tokenNotifier.removeListener(_onTokenChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (role == null) {
      return const Center(child: Text('Данные не найдены'));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPaper,
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AnnouncementsTabBar(tabController: _tabController),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Card(
            child: TabBarView(
              controller: _tabController,
              children: [
                const Center(
                  child: AnnouncementsListViewAll(),
                ),
                if (role == UserRole.student)
                  const Center(
                    child: AnnouncementsListViewByClass(),
                  ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
