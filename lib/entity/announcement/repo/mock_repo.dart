import 'package:ratingus_mobile/entity/announcement/mock/announcements.dart';
import 'package:ratingus_mobile/entity/announcement/model/announcement_model.dart';
import 'package:ratingus_mobile/shared/utils/connection_simulator.dart';

import 'abstract_repo.dart';

// class MockAnnouncementRepo extends AbstractAnnouncementRepo {
//   @override
//   Future<List<Announcement>> getAll() {
//     return ConnectionSimulator<List<Announcement>>().connect(() {
//       return announcements;
//     });
//   }
//
//   @override
//   Future<List<Announcement>> getByClass(int classId) {
//     return ConnectionSimulator<List<Announcement>>().connect(() {
//       return announcements
//           .where((announcement) => announcement.classes
//           .any((announcementClass) => announcementClass.id == classId))
//           .toList();
//     });
//   }
// }