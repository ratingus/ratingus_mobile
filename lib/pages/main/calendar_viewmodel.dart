import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/class/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/study/model/day_study.dart';
import 'package:ratingus_mobile/entity/study/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

class CalendarPageViewModel {
  final TokenNotifier _tokenNotifier;
  final Api api;
  final ValueNotifier<List<DayStudy>> _studyList = ValueNotifier([]);
  final ValueNotifier<List<ClassItem>> _classesInSchool = ValueNotifier([]);
  final ValueNotifier<ClassItem?> _selectedClass = ValueNotifier(null);

  CalendarPageViewModel(this._tokenNotifier, this.api) {
    _tokenNotifier.addListener(_onTokenChanged);
    _initData();
  }

  Future<void> _initData() async {
    await refreshClasses();
    var clazz = await getClassFromToken();
    if (clazz == null) return;
    await refreshStudies(clazz);
  }

  void dispose() {
    _tokenNotifier.removeListener(_onTokenChanged);
  }

  void _onTokenChanged() {
    refreshClasses();
    getClassFromToken().then((clazz) {
      if (clazz != null) {
        refreshStudies(clazz);
      }
    });
  }

  Future<ClassItem?> getClassFromToken() async {
    var jwt = await api.decodeToken();
    if (jwt.classId == null || jwt.className == null) {
      var clazz = _classesInSchool.value.firstOrNull;
      if (_classesInSchool.value.where((e) => e.name == _selectedClass.value?.name).firstOrNull == null || (clazz != null && _selectedClass.value == null)) {
        _selectedClass.value = clazz;
        return clazz;
      } else {
        return _selectedClass.value;
      }
    }
    if (_classesInSchool.value.where((e) => e.name == _selectedClass.value?.name).firstOrNull == null) {
      var clazz = ClassItem(id: jwt.classId!, name: jwt.className!);
      _selectedClass.value = clazz;
      return clazz;
    }
    return _selectedClass.value;
  }

  Future<void> fetchStudies(ClassItem selectedClass) async {
    var studyRepo = GetIt.I<AbstractStudyRepo>();
    var list = await studyRepo.getByClass(selectedClass.id);
    _studyList.value = list;
  }

  Future<void> fetchClasses() async {
    var classRepo = GetIt.I<AbstractClassRepo>();
    var classes = await classRepo.getAll();
    _classesInSchool.value = classes;
  }

  Future<void> refreshClasses() async {
    await fetchClasses();
  }

  Future<void> refreshStudies(ClassItem clazz) async {
    await fetchStudies(clazz);
  }

  ValueNotifier<List<DayStudy>> get studyList => _studyList;
  ValueNotifier<List<ClassItem>> get classesInSchool => _classesInSchool;
  ValueNotifier<ClassItem?> get selectedClass => _selectedClass;

  setSelectedClass(ClassItem? classInSchool) {
    _selectedClass.value = classInSchool;
  }
}