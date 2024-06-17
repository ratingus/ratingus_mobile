import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ratingus_mobile/shared/components/date_selector.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/widget/diary/diary_list_by_day.dart';

import 'diary_provider.dart';

@RoutePage()
class DiaryByDayPage extends StatefulWidget {
  final DateTime date;

  const DiaryByDayPage({super.key, required this.date});

  @override
  State<DiaryByDayPage> createState() => _DiaryByDayPageState();
}

class _DiaryByDayPageState extends State<DiaryByDayPage> {
  DateTime selectedDay = DateTime.now();
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    selectedDay = widget.date;
    _pageController = PageController(initialPage: selectedDay.weekday);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiaryProvider>(context, listen: false).fetchLessonsByDay(selectedDay);
    });
  }

  void nextDayOfWeek() {
    setState(() {
      selectedDay.add(const Duration(days: 1));
    });
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void prevDayOfWeek() {
    setState(() {
      selectedDay.subtract(const Duration(days: 1));
    });
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void setDayOfWeek(DateTime selectedDate) async {
    setState(() {
      selectedDay = selectedDate;
    });
    _pageController.jumpToPage(selectedDay.weekday);
  }

  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final dayLessons = diaryProvider.dayLessons;
    final dayLesson = diaryProvider.dayLesson;
    final isDayLessonLoading = diaryProvider.isDayLessonLoading;

    int maxDaysInWeek = 0;
    for (int i = 0; i < (dayLessons?.length ?? 0); i++) {
        if (dayLessons![i].studies.length > maxDaysInWeek) {
          maxDaysInWeek = dayLessons.length;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPaper,
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return DateSelector(
                selectedDate: selectedDay,
                next: nextDayOfWeek,
                prev: prevDayOfWeek,
                set: setDayOfWeek,
                renderSelectDate: ({required DateTime selectedDate}) {
                  return Text(
                      '${capitalize(DateFormat('EEE', 'ru').format(selectedDate))}, ${getDayMonth(selectedDate)}',
                      style: Theme.of(context).textTheme.displaySmall);
                },
              );
            },
          ),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int index) async {
          setState(() {
            if (index == 0) {
              AutoRouter.of(context).popAndPush(DiaryByDayRoute(
                  date: selectedDay.subtract(Duration(days: (8 - maxDaysInWeek)))));
            } else if (index == (maxDaysInWeek + 1)) {
              AutoRouter.of(context).popAndPush(DiaryByDayRoute(
                  date: selectedDay.add(Duration(days: (8 - maxDaysInWeek)))));
            } else {
              selectedDay =
                  selectedDay.add(Duration(days: index - selectedDay.weekday));
            }
          });
          if (index > 0 && index < (maxDaysInWeek + 1)) {
            await diaryProvider.fetchLessonsByDay(selectedDay);
          }
        },
        itemCount: maxDaysInWeek + 2,
        itemBuilder: (context, index) {
          return RefreshIndicator(
              onRefresh: () async {
                await diaryProvider.fetchLessonsByDay(selectedDay);
              },
              child: dayLesson == null ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Расписания ещё нет или его не удалось получить'),
                          ElevatedButton(
                            onPressed: () => diaryProvider.fetchLessonsByDay(selectedDay),
                            child: const Text('Повторить'),
                          ),
                        ],
                      ),
                    ) : isDayLessonLoading ? const Center(child: CircularProgressIndicator()) :  Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: DiaryListByDay(
                          lessonList: [dayLesson],
                        ),
                      ),
                    )
              );
        },
      ),
    );
  }
}
