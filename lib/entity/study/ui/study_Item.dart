import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/timetable/mock/timetable.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class StudyItem extends StatelessWidget {
  final Study study;

  const StudyItem({super.key, required this.study});

  @override
  Widget build(BuildContext context) {
    final timeTableEntry =
        currentTimetable.timetableEntry[study.timetableNumber - 1];

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.backgroundMain,
        ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                child: Column(
                  children: [
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '№${study.timetableNumber.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: AppColors.textHelper),
                            ),
                            Text(
                              timeTableEntry.getTime(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: AppColors.textHelper),
                            ),
                          ]),
                    )),
                    const SizedBox(height: 4),
                    Card(
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8),
                        title: Text(
                          study.subject,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: AppColors.primaryMain),
                        ),
                        subtitle: Text(
                          study.teacher.getFio(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    )
                  ],
                )));
  }
}
