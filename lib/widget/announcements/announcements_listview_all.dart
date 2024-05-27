import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/announcement/model/announcement_model.dart';
import 'package:ratingus_mobile/entity/announcement/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/announcement/ui/announcement_list_item.dart';

import 'package:ratingus_mobile/entity/announcement/mock/announcements.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';

class AnnouncementsListViewAll extends StatefulWidget {
  const AnnouncementsListViewAll({super.key});

  @override
  State<AnnouncementsListViewAll> createState() => _AnnouncementsListViewAllState();
}

class _AnnouncementsListViewAllState extends State<AnnouncementsListViewAll> {
  late Future<List<Announcement>> _announcementsFuture;
  late final TokenNotifier _tokenNotifier;

  @override
  void initState() {
    super.initState();
    _announcementsFuture = _fetchAnnouncements();
    _tokenNotifier = GetIt.I<TokenNotifier>();
    _tokenNotifier.addListener(_onTokenChanged);
  }

  @override
  void dispose() {
    _tokenNotifier.removeListener(_onTokenChanged);
    super.dispose();
  }

  void _onTokenChanged() {
    setState(() {
      _announcementsFuture = _fetchAnnouncements();
    });
  }

  Future<List<Announcement>> _fetchAnnouncements() {
    var announcementRepo = GetIt.I<AbstractAnnouncementRepo>();
    return announcementRepo.getAll();
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
            var announcements = snapshot.data;

            if (announcements == null) return const SizedBox();

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
        },
      ),
    );
  }
}
