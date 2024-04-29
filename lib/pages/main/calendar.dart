import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/class/mock/classes.dart';
import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/study/mock/raspisanie.dart';
import 'package:ratingus_mobile/entity/study/model/day_study.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/study/ui/study_item.dart';
import 'package:ratingus_mobile/entity/user/mock/user.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';
import 'package:ratingus_mobile/widget/study/study_list_view.dart';

@RoutePage()
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final classesInSchool = classes;
  final studyList = raspisanie;
  ClassItem? _selectedClass;

  @override
  void initState() {
    super.initState();
    _selectedClass = classesInSchool
        .firstWhere((classItem) => classItem.id == currentUser.classId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: DropdownButton<String>(
                hint: const Text('Выберите класс'),
                value: _selectedClass?.name,
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
                        .firstOrNull;
                  });
                },
              ),
            )),
        body: Center(
            child: StudyListView<DayStudy, Study>(
          list: studyList,
          renderDay: (currentStudyDay) => Text(
            capitalize(DateFormat('EEEE', 'ru')
                .format(getDayOfWeek(currentStudyDay.dayOfWeek))),
            style: Theme.of(context).textTheme.displayMedium,
          ),
          renderItem: (study, day) => StudyItem(
            study: study,
          ),
        )));
  }
}
