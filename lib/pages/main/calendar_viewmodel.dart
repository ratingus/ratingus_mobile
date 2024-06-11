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
  ClassItem? _selectedClass;

  CalendarPageViewModel(this._tokenNotifier, this.api) {
    _tokenNotifier.addListener(_onTokenChanged);
    _initData();
  }

  Future<void> _initData() async {
    var clazz = await getClassFromToken();
    await refreshStudies(clazz);
    await refreshClasses();
  }

  void dispose() {
    _tokenNotifier.removeListener(_onTokenChanged);
  }

  void _onTokenChanged() {
    getClassFromToken().then((clazz) {
      refreshStudies(clazz);
      refreshClasses();
    });
  }

  Future<ClassItem> getClassFromToken() async {
    var jwt = await api.decodeToken();
    var clazz = ClassItem(id: jwt.classId!, name: jwt.className!);
    _selectedClass = clazz;
    return clazz;
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
  ClassItem? get selectedClass => _selectedClass;

  setSelectedClass(ClassItem classInSchool) {
    _selectedClass = classInSchool;
  }
}