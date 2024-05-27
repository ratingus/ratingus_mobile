import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';

import 'package:ratingus_mobile/widget/diary/diary_list_by_week.dart';

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
  late final TokenNotifier _tokenNotifier;
  int weekOfYear = getAcademicWeekOfYear(DateTime.now());
  PageController _pageController = PageController();
  final diaryRepo = GetIt.I<AbstractLessonRepo>();
  late Future<List<DayLesson>> _dayLessons;

  @override
  void initState() {
    super.initState();
    print("base week of year = $weekOfYear");
    _pageController = PageController(initialPage: weekOfYear);

    _dayLessons = _fetchDayLessons();
    _tokenNotifier = GetIt.I<TokenNotifier>();
    _tokenNotifier.addListener(_onTokenChanged);
  }

  void _onTokenChanged() {
    setState(() {
      _dayLessons = _fetchDayLessons();
    });
  }

  @override
  void dispose() {
    _tokenNotifier.removeListener(_onTokenChanged);
    super.dispose();
  }

  Future<List<DayLesson>> _fetchDayLessons() {
    return diaryRepo.getByWeek(getAcademicDateByWeek(weekOfYear));
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

  void setWeek(DateTime selectedDate) {
    setState(() {
      weekOfYear = getAcademicWeekOfYear(selectedDate);
    });
    _pageController.jumpToPage(weekOfYear);
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
            _dayLessons = _fetchDayLessons();
          });
        },
        itemCount: 52, // Maximum number of weeks in a year - 53
        itemBuilder: (context, index) {
          return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _dayLessons = _fetchDayLessons();
                });
          },
          child: FutureBuilder<List<DayLesson>>(
            future: _dayLessons,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Расписания ещё нет или его не удалось получить'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _dayLessons = _fetchDayLessons();
                          });
                        },
                        child: const Text('Повторить'),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                final dayLessons = snapshot.data!;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: dayLessons.isNotEmpty ? DiaryListByWeek(
                      lessonList: dayLessons,
                    ) :
                      const Text('В этот день нет ни одного занятия'),
                  ),
                );
              } else {
                return const Center(child: Text('Нет данных'));
              }
            },
          ));
        },
      ),
    );
  }
}
