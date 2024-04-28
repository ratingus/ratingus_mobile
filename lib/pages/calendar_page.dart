import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/class/mock/classes.dart';
import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/study/mock/raspisanie.dart';
import 'package:ratingus_mobile/entity/study/ui/study_Item.dart';
import 'package:ratingus_mobile/entity/user/mock/user.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

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
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                itemBuilder: (BuildContext dayContext, int dayIndex) {
                  final currentStudyDay = studyList[dayIndex];
                  return Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  capitalize(DateFormat('EEEE', 'ru').format(
                                      getDayOfWeek(currentStudyDay.dayOfWeek))),
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return StudyItem(
                                      study: currentStudyDay.studies[index],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      thickness: 10.0,
                                      color: Colors.transparent,
                                    );
                                  },
                                  itemCount: currentStudyDay.studies.length)
                            ],
                          )));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    thickness: 10.0,
                    color: Colors.transparent,
                  );
                },
                itemCount: studyList.length)));
  }
}
