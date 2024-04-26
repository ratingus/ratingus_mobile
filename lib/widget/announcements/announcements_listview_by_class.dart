import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/announcement/ui/announcement_list_item.dart';

import 'package:ratingus_mobile/entity/announcement/mock/announcements.dart';
import 'package:ratingus_mobile/entity/user/mock/user.dart';

class AnnouncementsListViewByClass extends StatefulWidget {
  const AnnouncementsListViewByClass({super.key});

  @override
  State<AnnouncementsListViewByClass> createState() => _AnnouncementsListViewByClassState();
}

class _AnnouncementsListViewByClassState extends State<AnnouncementsListViewByClass> {
  @override
  Widget build(BuildContext context) {
    int userClassId = currentUser.classId;
    var announcementsByClass = announcements
        .where((announcement) => announcement.classes
            .any((announcementClass) => announcementClass.id == userClassId))
        .toList();

    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: announcementsByClass.length,
      itemBuilder: (BuildContext context, int index) {
        return AnnouncementListItem(announcement: announcementsByClass[index]);
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
