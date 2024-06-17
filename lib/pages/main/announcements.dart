import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
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
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPaper,
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: AnnouncementsTabBar(tabController: _tabController),
          )
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Card(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Center(
                      child: AnnouncementsListViewAll()
                    ),
                    Center(
                      child: AnnouncementsListViewByClass(),
                    ),
                  ],
                ),
            )
        )
    );
  }
}
