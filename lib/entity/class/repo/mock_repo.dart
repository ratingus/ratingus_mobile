
import 'package:ratingus_mobile/entity/class/mock/classes.dart';
import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/shared/utils/connection_simulator.dart';

import 'abstract_repo.dart';

class MockClassRepo extends AbstractClassRepo {
  @override
  Future<List<ClassItem>> getAll() {
    return ConnectionSimulator<List<ClassItem>>().connect(() {
      return classes;
    });
  }

}