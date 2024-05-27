import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/shared/components/swiper.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';
import 'package:ratingus_mobile/widget/diary/diary_list_by_lesson.dart';

import 'diary_provider.dart';

@RoutePage()
class DiaryByLessonPage extends StatefulWidget {
  final DateTime dayLessonDetail;
  final int selectedLesson;

  const DiaryByLessonPage(
      {super.key, required this.dayLessonDetail, required this.selectedLesson});

  @override
  State<DiaryByLessonPage> createState() => _DiaryByLessonPageState();
}

class _DiaryByLessonPageState extends State<DiaryByLessonPage> {
  late int selectedLesson;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    selectedLesson = widget.selectedLesson;
    _pageController = PageController(initialPage: selectedLesson);
  }

  void nextLesson() {
    setState(() {
      if (selectedLesson < 2) {
        selectedLesson++;
      }
    });
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void prevLesson() {
    setState(() {
      if (selectedLesson > 0) {
        selectedLesson--;
      }
    });
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void setLesson(Lesson selectedLessonValue) async {
    setState(() {
      selectedLesson = selectedLessonValue.timetableNumber - 1;
    });
    _pageController.jumpToPage(selectedLesson);
  }

  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final dayLesson = diaryProvider.dayLesson;
    final isDayLessonLoading = diaryProvider.isDayLessonLoading;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.backgroundPaper,
            toolbarHeight: 0,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(64),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return dayLesson == null
                        ? const Center(child: CircularProgressIndicator())
                        : isDayLessonLoading
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        'Расписания ещё нет или его не удалось получить'),
                                    ElevatedButton(
                                      onPressed: () =>
                                          diaryProvider.fetchLessonsByDay(
                                              widget.dayLessonDetail),
                                      child: const Text('Повторить'),
                                    ),
                                  ],
                                ),
                              )
                            : Swiper<Lesson>(
                                selectedValue:
                                    dayLesson.lessons[selectedLesson],
                                prev: prevLesson,
                                next: nextLesson,
                                set: setLesson,
                                renderSelectedValue: (Lesson selectedValue) {
                                  return Column(
                                    children: [
                                      DropdownButton(
                                          icon: arrowDown,
                                          underline: const SizedBox(
                                            height: 0,
                                          ),
                                          selectedItemBuilder:
                                              (BuildContext context) {
                                            return dayLesson.lessons
                                                .map((lesson) {
                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 12),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        lesson.subject,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .displaySmall,
                                                      ),
                                                      Text(
                                                        selectedValue.teacher
                                                            .getFio(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall
                                                            ?.copyWith(
                                                                color: AppColors
                                                                    .textHelper),
                                                      ),
                                                    ],
                                                  ));
                                            }).toList();
                                          },
                                          value: selectedValue,
                                          items: dayLesson.lessons
                                              .map((lesson) =>
                                                  DropdownMenuItem<Lesson>(
                                                    value: lesson,
                                                    child: Text(
                                                      lesson.subject,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall
                                                          ?.copyWith(
                                                              color: selectedValue
                                                                          .lessonId ==
                                                                      lesson
                                                                          .lessonId
                                                                  ? AppColors
                                                                      .primaryMain
                                                                  : AppColors
                                                                      .textPrimary),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (newLesson) {
                                            setState(() {
                                              if (newLesson != null) {
                                                setLesson(newLesson);
                                              }
                                            });
                                          }),
                                    ],
                                  );
                                },
                                selectValue: (Lesson selectedValue) {
                                  return selectedValue;
                                },
                              );
                  },
                ))),
        body: dayLesson == null
            ? const Center(child: CircularProgressIndicator())
            : isDayLessonLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'Расписания ещё нет или его не удалось получить'),
                        ElevatedButton(
                          onPressed: () => diaryProvider
                              .fetchLessonsByDay(widget.dayLessonDetail),
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  )
                : PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        selectedLesson = index;
                      });
                    },
                    itemCount: dayLesson.lessons.length,
                    itemBuilder: (context, index) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          diaryProvider
                              .fetchLessonsByDay(widget.dayLessonDetail);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Card(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    DiaryListByLesson(
                                      dayLessonDetail: dayLesson,
                                      selectedLesson: index,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ));
  }
}
