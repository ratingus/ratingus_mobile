import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson.dart';
import 'package:ratingus_mobile/shared/components/swiper.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';
import 'package:ratingus_mobile/widget/diary/diary_list_by_lesson.dart';

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
  }

  void nextLesson() {
    setState(() {
      if (selectedLesson < widget.day.studies.length - 1) {
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

  void setLesson(Lesson lesson) async {
    setState(() {
      selectedLesson = widget.day.studies.indexOf(lesson);
    });
    _pageController.jumpToPage(selectedLesson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.backgroundPaper,
            toolbarHeight: 0,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(64),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Swiper<Lesson>(
                                selectedValue:
                                    widget.day.studies[selectedLesson],
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
                                            return widget.day.studies
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
                                                      selectedValue.teacher != null ?
                                                      Text(
                                                        selectedValue.teacher!
                                                            .getFio(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall
                                                            ?.copyWith(
                                                                color: AppColors
                                                                    .textHelper),
                                                      ) : const SizedBox()
                                                    ],
                                                  ));
                                            }).toList();
                                          },
                                          value: selectedValue,
                                          items: widget.day.studies
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
                                                                          .scheduleId ==
                                                                      lesson
                                                                          .scheduleId
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
        body: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        selectedLesson = index;
                      });
                    },
                    itemCount: widget.day.studies.length,
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
                                      dayLessonDetail: widget.day,
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
