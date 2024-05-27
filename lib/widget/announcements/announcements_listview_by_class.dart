import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:ratingus_mobile/entity/announcement/model/announcement_model.dart';
import 'package:ratingus_mobile/entity/announcement/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/announcement/ui/announcement_list_item.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/user/mock/user.dart';
import 'package:ratingus_mobile/entity/user/model/jwt.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class AnnouncementsListViewByClass extends StatefulWidget {
  const AnnouncementsListViewByClass({super.key});

  @override
  State<AnnouncementsListViewByClass> createState() => _AnnouncementsListViewByClassState();
}

class _AnnouncementsListViewByClassState extends State<AnnouncementsListViewByClass> {
  late Future<List<Announcement>> _announcementsFuture;
  late final TokenNotifier _tokenNotifier;
  final api = GetIt.I<Api>();

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

  Future<List<Announcement>> _fetchAnnouncements() async {
    JWT jwt = await api.decodeToken();
    var announcementRepo = GetIt.I<AbstractAnnouncementRepo>();
    return announcementRepo.getByClass(jwt.classId!);
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
