import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

import 'abstract_repo.dart';

class HttpClassRepo extends AbstractClassRepo {
  final api = GetIt.I<Api>();
  @override
  Future<List<ClassItem>> getAll() async {
    try {
      final response = await api.dio.get('/admin-panel/class');
      debugPrint('Response: ${response.data}');
      return (response.data as List<dynamic>)
          .map((e) => ClassItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

}