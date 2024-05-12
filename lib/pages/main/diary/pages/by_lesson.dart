import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ratingus_mobile/entity/lesson/model/day_lesson_detail.dart';
import 'package:ratingus_mobile/entity/lesson/model/lesson_detail.dart';
import 'package:ratingus_mobile/entity/lesson/repo/abstract_repo.dart';
import 'package:ratingus_mobile/shared/components/swiper.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';
import 'package:ratingus_mobile/shared/theme/consts/icons.dart';
import 'package:ratingus_mobile/widget/diary/diary_list_by_lesson.dart';

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
  late Future<DayLessonDetail> _dayLessonDetail;
  late int selectedLesson;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _dayLessonDetail = _fetchLessons(widget.dayLessonDetail);
    selectedLesson = widget.selectedLesson;
    _pageController = PageController(initialPage: selectedLesson);
  }

  Future<DayLessonDetail> _fetchLessons(DateTime dateTime) {
    var lessonRepo = GetIt.I<AbstractLessonRepo>();
    return lessonRepo.getByDay(dateTime);
  }

  Future<void> _refreshLessons(DateTime dateTime) async {
    setState(() {
      _dayLessonDetail = _fetchLessons(dateTime);
    });
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

  void setLesson(LessonDetail selectedLessonValue) async {
    setState(() {
      selectedLesson = selectedLessonValue.timetableNumber - 1;
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
            return FutureBuilder<DayLessonDetail>(
              future: _dayLessonDetail,
              builder: (BuildContext context,
                  AsyncSnapshot<DayLessonDetail> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: ${snapshot.error}'),
                        ElevatedButton(
                          onPressed: () =>
                              _refreshLessons(widget.dayLessonDetail),
                          child: const Text('Повторить'),
                        ),
                      ],
                    ),
                  );
                } else {
                  var dayLessonDetail = snapshot.data;
                  if (dayLessonDetail == null) return const SizedBox();
                  return Swiper<LessonDetail>(
                    selectedValue: dayLessonDetail.studies[selectedLesson],
                    prev: prevLesson,
                    next: nextLesson,
                    set: setLesson,
                    renderSelectedValue: (LessonDetail selectedValue) {
                      return Column(
                        children: [
                          DropdownButton(
                              icon: arrowDown,
                              underline: const SizedBox(
                                height: 0,
                              ),
                              selectedItemBuilder: (BuildContext context) {
                                return dayLessonDetail.studies.map((lesson) {
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
                                            selectedValue.teacher.getFio(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    color:
                                                        AppColors.textHelper),
                                          ),
                                        ],
                                      ));
                                }).toList();
                              },
                              value: selectedValue,
                              items: dayLessonDetail.studies
                                  .map((lesson) =>
                                      DropdownMenuItem<LessonDetail>(
                                        value: lesson,
                                        child: Text(
                                          lesson.subject,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.copyWith(
                                                  color: selectedValue.id ==
                                                          lesson.id
                                                      ? AppColors.primaryMain
                                                      : AppColors.textPrimary),
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
                    selectValue: (LessonDetail selectedValue) {
                      return selectedValue;
                    },
                  );
                }
              },
            );
          }),
        ),
      ),
      body: FutureBuilder<DayLessonDetail>(
        future: _dayLessonDetail,
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
                    onPressed: () => _refreshLessons(widget.dayLessonDetail),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          } else {
            var dayLessonDetail = snapshot.data;
            if (dayLessonDetail == null) return const SizedBox();
            return PageView.builder(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  selectedLesson = index;
                });
              },
              itemCount: dayLessonDetail.studies.length,
              itemBuilder: (context, index) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _refreshLessons(widget.dayLessonDetail);
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
                                dayLessonDetail: dayLessonDetail,
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
            );
          }
        },
      ),
    );
  }
}
