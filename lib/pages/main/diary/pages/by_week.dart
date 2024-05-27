import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ratingus_mobile/widget/diary/diary_list_by_week.dart';

import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/components/date_selector.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

import 'diary_provider.dart';

@RoutePage()
class DiaryByWeekPage extends StatefulWidget {
  const DiaryByWeekPage({super.key});

  @override
  State<DiaryByWeekPage> createState() => _DiaryByWeekPageState();
}

class _DiaryByWeekPageState extends State<DiaryByWeekPage> {
  int weekOfYear = getAcademicWeekOfYear(DateTime.now());
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    print("base week of year = $weekOfYear");
    _pageController = PageController(initialPage: weekOfYear);
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
    _pageController.jumpToPage(weekOfYear);
  }

  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final dayLessons = diaryProvider.dayLessons;
    final isDayLessonsLoading = diaryProvider.isDayLessonsLoading;

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
          });
          diaryProvider.fetchDayLessons(getAcademicDateByWeek(weekOfYear));
        },
        itemCount: 52, // Maximum number of weeks in a year - 53
        itemBuilder: (context, index) {
          return RefreshIndicator(
            onRefresh: () async {
              await diaryProvider.fetchDayLessons(getAcademicDateByWeek(weekOfYear));
            },
            child: isDayLessonsLoading ? const Center(child: CircularProgressIndicator()) : dayLessons == null ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Расписания ещё нет или его не удалось получить'),
                        ElevatedButton(
                          onPressed: () => diaryProvider.fetchDayLessons(getAcademicDateByWeek(weekOfYear)),
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  ) : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: DiaryListByWeek(
                        lessonList: dayLessons,
                      ),
                    ),
                  )
            );
        },
      ),
    );
  }
}
