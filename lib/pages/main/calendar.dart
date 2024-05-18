import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:ratingus_mobile/widget/study/study_list_view.dart';

import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/class/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/study/model/day_study.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/study/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/study/ui/study_item.dart';
import 'package:ratingus_mobile/entity/user/mock/user.dart';

import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

@RoutePage()
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}
class _CalendarPageState extends State<CalendarPage> {
  late Future<List<DayStudy>> _studyList;
  late Future<List<ClassItem>> _classesInSchool;
  ClassItem _selectedClass = currentUser.classId;

  @override
  void initState() {
    super.initState();
    _studyList = _fetchStudies(_selectedClass.id);
    _classesInSchool = _fetchClasses();
  }

  Future<List<DayStudy>> _fetchStudies(int classId) {
    var studyRepo = GetIt.I<AbstractStudyRepo>();
    return studyRepo.getByClass(classId);
  }

  Future<List<ClassItem>> _fetchClasses() {
    var classRepo = GetIt.I<AbstractClassRepo>();
    return classRepo.getAll();
  }


  Future<void> _refreshClasses() async {
    setState(() {
      _classesInSchool = _fetchClasses();
    });
  }
  Future<void> _refreshStudies() async {
    setState(() {
      _studyList = _fetchStudies(_selectedClass.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPaper,
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: FutureBuilder<List<ClassItem>>(
            future: _classesInSchool,
            builder: (BuildContext context, AsyncSnapshot<List<ClassItem>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _refreshClasses,
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                );
              } else {
                var classesInSchool = snapshot.data;
                if (classesInSchool == null) return const SizedBox();
                return DropdownButton<String>(
                  hint: const Text('Выберите класс'),
                  value: _selectedClass.name,
                  icon: arrowDown,
                  underline: const SizedBox(
                    height: 0,
                  ),
                  selectedItemBuilder: (BuildContext context) {
                    return classesInSchool.map((ClassItem classItem) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Center(
                          child: Text(
                            classItem.name,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  items: classesInSchool.map((ClassItem classItem) {
                    return DropdownMenuItem<String>(
                      value: classItem.name,
                      child: Text(classItem.name),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedClass = classesInSchool
                          .where((classItem) => classItem.name == newValue)
                          .firstOrNull!;
                    });
                    _refreshStudies();
                  },
                );
              }
            },
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshStudies,
        child: FutureBuilder<List<DayStudy>>(
          future: _studyList,
          builder: (BuildContext context, AsyncSnapshot<List<DayStudy>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${snapshot.error}'),
                    ElevatedButton(
                      onPressed: _refreshStudies,
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              );
            } else {
              var studyList = snapshot.data;
              if (studyList == null) return const SizedBox();
              return StudyListView<DayStudy, Study>(
                list: studyList,
                renderDay: (currentStudyDay) => Text(
                  capitalize(DateFormat('EEEE', 'ru')
                      .format(getDayOfWeek(currentStudyDay.dayOfWeek))),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                renderItem: (study, day) => StudyItem(
                  study: study,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}