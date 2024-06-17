import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ratingus_mobile/entity/auth/utils/token_notifier.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';

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
  late final TokenNotifier _tokenNotifier;
  int weekOfYear = getAcademicWeekOfYear(DateTime.now());
  PageController _pageController = PageController();
  final diaryRepo = GetIt.I<AbstractLessonRepo>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: weekOfYear);

    _tokenNotifier = GetIt.I<TokenNotifier>();
    _tokenNotifier.addListener(_onTokenChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DiaryProvider>(context, listen: false).fetchDayLessons(getAcademicDateByWeek(weekOfYear));
    });
  }

  void _onTokenChanged() {
    final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
    diaryProvider.fetchDayLessons(getAcademicDateByWeek(weekOfYear));
    setState(() {});
  }

  @override
  void dispose() {
    _tokenNotifier.removeListener(_onTokenChanged);
    super.dispose();
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
          final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
          diaryProvider.fetchDayLessons(getAcademicDateByWeek(index));
          setState(() {
            weekOfYear = index;
          });
        },
        itemCount: 52, // Maximum number of weeks in a year - 53
        itemBuilder: (context, index) {
          return RefreshIndicator(
              onRefresh: () async {
                final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
                diaryProvider.fetchDayLessons(getAcademicDateByWeek(weekOfYear));
              },
              child: isDayLessonsLoading ? const Center(child: CircularProgressIndicator()) :
              dayLessons == null ?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Расписания ещё нет или его не удалось получить'),
                    ElevatedButton(
                      onPressed: () {
                        final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
                        diaryProvider.fetchDayLessons(getAcademicDateByWeek(weekOfYear));
                      },
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ) : dayLessons.isNotEmpty ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: dayLessons.isNotEmpty ? DiaryListByWeek(
                    lessonList: dayLessons,
                  ) :
                  const Text('В этот день нет ни одного занятия'),
                ),
              ) : const Center(child: Text('Нет данных')));
        },
      ),
    );
  }
}
