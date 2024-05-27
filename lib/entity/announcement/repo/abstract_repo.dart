import 'package:ratingus_mobile/entity/announcement/model/announcement_model.dart';

abstract class AbstractAnnouncementRepo {
  Future<List<Announcement>> getAll();
  Future<List<Announcement>> getByClass(int classId);
}