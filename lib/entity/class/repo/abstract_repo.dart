import 'package:ratingus_mobile/entity/class/model/class_model.dart';

abstract class AbstractClassRepo {
  Future<List<ClassItem>> getAll();
}