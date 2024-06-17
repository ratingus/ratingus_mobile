import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/shared/api/api_dio.dart';

import 'package:ratingus_mobile/widget/study/study_list_view.dart';

import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/entity/class/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/study/model/day_study.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/study/repo/abstract_repo.dart';
import 'package:ratingus_mobile/entity/study/ui/study_item.dart';

import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';

import 'calendar_viewmodel.dart';

@RoutePage()
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final CalendarPageViewModel viewModel;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    viewModel = CalendarPageViewModel(GetIt.I<TokenNotifier>(), GetIt.I<Api>());
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (viewModel.selectedClass.value != null) {
        await viewModel.refreshStudies(viewModel.selectedClass.value!);
      }
      await viewModel.refreshClasses();
      await viewModel.getClassFromToken();
    } catch (e) {
      // handle exception if needed
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPaper,
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: ValueListenableBuilder<List<ClassItem>>(
            valueListenable: viewModel.classesInSchool,
            builder: (BuildContext context, List<ClassItem> classesInSchool, Widget? child) {
              if (classesInSchool.isEmpty) {
                return TextButton(
                  child: Text("Классы не найдены",
                      style: Theme.of(context).textTheme.displaySmall),
                  onPressed: () async {
                    await viewModel.refreshClasses();
                  },
                );
              } else if (classesInSchool.length == 1) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Center(
                    child: Text(
                      classesInSchool[0].name,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                );
              } else {
                return ValueListenableBuilder(valueListenable: viewModel.selectedClass, builder: (BuildContext context, ClassItem? selectedClass, Widget? child) {
                  return DropdownButton<String>(
                    hint: const Text('Выберите класс'),
                    value: selectedClass?.name,
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
                        viewModel.setSelectedClass(classesInSchool
                            .firstWhere((classItem) => classItem.name == newValue));
                      });
                      if (selectedClass != null) {
                        viewModel.refreshStudies(selectedClass);
                      }
                    },
                  );
                });
              }
            },
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: ValueListenableBuilder<List<DayStudy>>(
          valueListenable: viewModel.studyList,
          builder: (BuildContext context, List<DayStudy> studyList, Widget? child) {
            if (studyList.isEmpty) {
              return const Center(child: Text('No data'));
            } else {
              return StudyListView<DayStudy, Study>(
                list: studyList,
                renderDay: (currentStudyDay) => Text(
                  capitalize(DateFormat('EEEE', 'ru')
                      .format(getDayOfWeek(currentStudyDay.dayOfWeek))),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                renderItem: (study, day, index) => StudyItem(
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
