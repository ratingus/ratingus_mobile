import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/announcement/ui/announcement_list_item.dart';

import 'package:ratingus_mobile/entity/announcement/mock/announcements.dart';

class AnnouncementsListViewAll extends StatefulWidget {
  const AnnouncementsListViewAll({super.key});

  @override
  State<AnnouncementsListViewAll> createState() => _AnnouncementsListViewAllState();
}

class _AnnouncementsListViewAllState extends State<AnnouncementsListViewAll> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: announcements.length,
      itemBuilder: (BuildContext context, int index) {
        return AnnouncementListItem(announcement: announcements[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 10.0,
          color: Colors.transparent,
        );
      },
    );
  }
}
