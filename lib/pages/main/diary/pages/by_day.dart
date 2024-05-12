import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson_detail.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/components/date_selector.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';
import 'package:ratingus_mobile/shared/router/router.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/widget/diary/diary_list_by_day.dart';

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
  late Future<DayLessonDetail> _dayLesson;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.date;
    _pageController = PageController(initialPage: selectedDay.weekday);
    _dayLesson = _fetchLessons(selectedDay);
  }

  Future<DayLessonDetail> _fetchLessons(DateTime dateTime) {
    var lessonRepo = GetIt.I<AbstractLessonRepo>();
    return lessonRepo.getByDay(dateTime);
  }

  Future<void> _refreshLessons(DateTime dateTime) async {
    setState(() {
      _dayLesson = _fetchLessons(dateTime);
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
        onPageChanged: (int index) {
          setState(() {
            if (index == 0) {
              AutoRouter.of(context).popAndPush(DiaryByDayRoute(
                  date: selectedDay.subtract(const Duration(days: 2))));
            } else if (index == 7) {
              AutoRouter.of(context).popAndPush(DiaryByDayRoute(
                  date: selectedDay.add(const Duration(days: 2))));
            } else {
              selectedDay =
                  selectedDay.add(Duration(days: index - selectedDay.weekday));
            }
          });
        },
        itemCount: 8,
        itemBuilder: (context, index) {
          return RefreshIndicator(
              onRefresh: () async {
                _refreshLessons(selectedDay);
              },
              child: FutureBuilder<DayLessonDetail>(
                future: _dayLesson,
                builder:
                    (BuildContext context, AsyncSnapshot<DayLessonDetail> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${snapshot.error}'),
                          ElevatedButton(
                            onPressed: () => _refreshLessons(selectedDay),
                            child: const Text('Повторить'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    var dayLesson = snapshot.data;
                    if (dayLesson == null) return const SizedBox();
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: DiaryListByDay(
                          lessonList: [dayLesson],
                        ),
                      ),
                    );
                  }
                },
              ));
        },
      ),
    );
  }
}
