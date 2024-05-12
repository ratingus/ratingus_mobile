import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:ratingus_mobile/entity/announcement/model/announcement_model.dart';
import 'package:ratingus_mobile/entity/announcement/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/announcement/ui/announcement_list_item.dart';
import 'package:ratingus_mobile/entity/user/mock/user.dart';

class AnnouncementsListViewByClass extends StatefulWidget {
  const AnnouncementsListViewByClass({super.key});

  @override
  State<AnnouncementsListViewByClass> createState() => _AnnouncementsListViewByClassState();
}

class _AnnouncementsListViewByClassState extends State<AnnouncementsListViewByClass> {
  late Future<List<Announcement>> _announcementsFuture;

  @override
  void initState() {
    super.initState();
    _announcementsFuture = _fetchAnnouncements();
  }

  Future<List<Announcement>> _fetchAnnouncements() {
    int userClassId = currentUser.classId.id;
    var announcementRepo = GetIt.I<AbstractAnnouncementRepo>();
    return announcementRepo.getByClass(userClassId);
  }

  Future<void> _refreshAnnouncements() async {
    setState(() {
      _announcementsFuture = _fetchAnnouncements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshAnnouncements,
      child: FutureBuilder<List<Announcement>>(
        future: _announcementsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Announcement>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: _refreshAnnouncements,
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          } else {
            var announcementsByClass = snapshot.data;

            if (announcementsByClass == null) return const SizedBox();

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
        },
      ),
    );
  }
}
