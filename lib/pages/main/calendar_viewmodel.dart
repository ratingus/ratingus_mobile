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
  late Future<List<DayStudy>> _studyList;
  late Future<List<ClassItem>> _classesInSchool;
  ClassItem? _selectedClass;

  CalendarPageViewModel(this._tokenNotifier, this.api) {
    _tokenNotifier.addListener(_onTokenChanged);
    getClassFromToken().then((clazz) {
      _studyList = fetchStudies(clazz);
    });
    _classesInSchool = fetchClasses();
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

  Future<List<DayStudy>> fetchStudies(ClassItem selectedClass) async {
    var studyRepo = GetIt.I<AbstractStudyRepo>();
    return studyRepo.getByClass(selectedClass.id);
  }

  Future<List<ClassItem>> fetchClasses() async {
    var classRepo = GetIt.I<AbstractClassRepo>();
    return await classRepo.getAll();
  }

  Future<void> refreshClasses() async {
    _classesInSchool = fetchClasses();
  }

  Future<void> refreshStudies(ClassItem clazz) async {
    _studyList = fetchStudies(clazz);
  }

  Future<List<DayStudy>> get studyList => _studyList;
  Future<List<ClassItem>> get classesInSchool => _classesInSchool;
  ClassItem? get selectedClass => _selectedClass;

  setSelectedClass(ClassItem classInSchool) {
    _selectedClass = classInSchool;
  }
}