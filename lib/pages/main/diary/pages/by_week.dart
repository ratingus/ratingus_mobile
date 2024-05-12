import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:ratingus_mobile/widget/diary/diary_list_by_week.dart';

import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';

import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/components/date_selector.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

@RoutePage()
class DiaryByWeekPage extends StatefulWidget {
  const DiaryByWeekPage({super.key});

  @override
  State<DiaryByWeekPage> createState() => _DiaryByWeekPageState();
}

class _DiaryByWeekPageState extends State<DiaryByWeekPage> {
  int weekOfYear = getAcademicWeekOfYear(DateTime.now());
  PageController _pageController = PageController();
  late Future<List<DayLesson>> _lessonList;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: weekOfYear);
    _lessonList = _fetchLessons(getAcademicDateByWeek(weekOfYear));
  }

  Future<List<DayLesson>> _fetchLessons(DateTime dateTime) {
    var lessonRepo = GetIt.I<AbstractLessonRepo>();
    return lessonRepo.getByWeek(dateTime);
  }

  Future<void> _refreshLessons(DateTime dateTime) async {
    setState(() {
      _lessonList = _fetchLessons(dateTime);
    });
  }

  void nextWeek() {
    setState(() {
      weekOfYear++;
    });
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void prevWeek() {
    setState(() {
      weekOfYear--;
    });
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void setWeek(DateTime selectedDate) async {
    setState(() {
      weekOfYear = getAcademicWeekOfYear(selectedDate);
    });
    _pageController.jumpToPage(weekOfYear - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPaper,
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return DateSelector(
                selectedDate: getAcademicDateByWeek(weekOfYear),
                next: nextWeek,
                prev: prevWeek,
                set: setWeek,
                renderSelectDate: ({required DateTime selectedDate}) {
                  return Text(getStringOfWeek(selectedDate),
                      style: Theme.of(context).textTheme.displaySmall);
                },
              );
            },
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            weekOfYear = index + 1;
            _lessonList = _fetchLessons(getAcademicDateByWeek(weekOfYear));
          });
        },
        itemCount: 52, // Maximum number of weeks in a year - 53
        itemBuilder: (context, index) {
          return RefreshIndicator(
            onRefresh: () async {
              _refreshLessons(getAcademicDateByWeek(weekOfYear));
            },
            child: FutureBuilder<List<DayLesson>>(
              future: _lessonList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<DayLesson>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${snapshot.error}'),
                        ElevatedButton(
                          onPressed: () => _refreshLessons(
                              getAcademicDateByWeek(weekOfYear)),
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  );
                } else {
                  var lessonList = snapshot.data;
                  if (lessonList == null) return const SizedBox();
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: DiaryListByWeek(
                        lessonList: lessonList,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
