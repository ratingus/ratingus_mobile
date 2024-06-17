import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/shared/components/swiper.dart';
import 'package:ratingus_mobile/shared/helpers/datetime.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';
import 'package:ratingus_mobile/widget/diary/diary_list_by_lesson.dart';

import 'diary_provider.dart';

@RoutePage()
class DiaryByLessonPage extends StatefulWidget {
  final DayLesson day;
  final int selectedLesson;
  final Future<void> Function() onRefetch;

  const DiaryByLessonPage(
      {super.key, required this.day, required this.selectedLesson, required this.onRefetch});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final diaryProvider = Provider.of<DiaryProvider>(context, listen: false);
      diaryProvider.fetchLesson(widget.day.dateTime, selectedLesson);
    });
  }

  @override
  Widget build(BuildContext context) {
    final diaryProvider = Provider.of<DiaryProvider>(context);
    final dayLesson = diaryProvider.dayLesson;
    final _lesson = diaryProvider.lesson;

    void nextLesson() async {
      if (dayLesson != null) {
        setState(() {
          if (selectedLesson < dayLesson.studies.length - 1) {
            selectedLesson++;
          }
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        diaryProvider.fetchLesson(widget.day.dateTime, selectedLesson);
      }
    }

    void prevLesson() async {
      if (dayLesson != null) {
        setState(() {
          if (selectedLesson > 0) {
            selectedLesson--;
          }
        });
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        diaryProvider.fetchLesson(widget.day.dateTime, selectedLesson);
      }
    }

    void setLesson(Lesson lesson) async {
      if (dayLesson != null) {
        setState(() {
          selectedLesson = dayLesson.studies.indexOf(lesson);
        });
        _pageController.jumpToPage(selectedLesson);
        diaryProvider.fetchLesson(widget.day.dateTime, selectedLesson);
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundPaper,
        toolbarHeight: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return _lesson != null && dayLesson != null
                  ? Swiper<Lesson>(
                selectedValue: _lesson,
                prev: prevLesson,
                next: nextLesson,
                set: setLesson,
                renderSelectedValue: (Lesson selectedValue) {
                  return Column(
                    children: [
                      DropdownButton<Lesson>(
                        icon: arrowDown,
                        underline: const SizedBox(height: 0),
                        selectedItemBuilder: (BuildContext context) {
                          return dayLesson.studies.map((lesson) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  Text(
                                    lesson.subject,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Text(
                                    selectedValue.teacher?.getFio() ?? 'Нет учителя',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: AppColors.textHelper),
                                  ),
                                ],
                              ),
                            );
                          }).toList();
                        },
                        value: selectedValue,
                        items: dayLesson.studies.map((lesson) {
                          return DropdownMenuItem<Lesson>(
                            value: lesson,
                            child: Text(
                              lesson.subject,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                color: selectedValue.scheduleId == lesson.scheduleId
                                    ? AppColors.primaryMain
                                    : AppColors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newLesson) {
                          if (newLesson != null) {
                            setLesson(newLesson);
                          }
                        },
                      ),
                    ],
                  );
                },
                selectValue: (Lesson selectedValue) {
                  return selectedValue;
                },
              )
                  : const Text("Загрузка...");
            },
          ),
        ),
      ),
      body: dayLesson != null
          ? PageView.builder(
        controller: _pageController,
        onPageChanged: (int index) {
          // Сейчас при создании нового Lesson после редактирования заметки ломается поиск в дропдауне (разные селекты)
          setState(() {
            selectedLesson = index;
          });
          diaryProvider.fetchLesson(dayLesson.dateTime, selectedLesson);
        },
        itemCount: dayLesson.studies.length,
        itemBuilder: (context, index) {
          return RefreshIndicator(
            onRefresh: widget.onRefetch,
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
                          onRefetch: widget.onRefetch,
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
      )
          : const Text("Загрузка..."),
    );
  }
}
