import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/announcement/model/announcement_model.dart';
import 'package:ratingus_mobile/entity/announcement/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class HttpAnnouncementRepo extends AbstractAnnouncementRepo {
  final api = GetIt.I<Api>();

  @override
  Future<List<Announcement>> getAll() async {
    try {
      final response = await api.dio.get('/announcements');
      debugPrint('Response: ${response.data}');
      return (response.data as List<dynamic>)
          .map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  @override
  Future<List<Announcement>> getByClass(int classId) async {
    try {
      final response = await api.dio.get('/announcements?classId=$classId');
      debugPrint('Response: ${response.data}');
      return (response.data as List<dynamic>)
          .map((e) => Announcement.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

}