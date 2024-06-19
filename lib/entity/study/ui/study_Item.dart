import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/study/model/study.dart';
import 'package:ratingus_mobile/entity/timetable/mock/timetable.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class StudyItem extends StatelessWidget {
  final Study study;
  final Widget? rightSlot;
  final Widget? bottomSlot;

  const StudyItem({
    super.key,
    required this.study,
    this.rightSlot,
    this.bottomSlot,
  });

  @override
  Widget build(BuildContext context) {
    final timeTableEntry =
        currentTimetable.timetableEntry[study.timetableNumber - 1];

    return Opacity(
        opacity: study.teacherSubjectId == -1 ? 0.6 : 1.0,
        child: Container(
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
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          timeTableEntry.getTime(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ]),
                )),
                const SizedBox(height: 4),
                SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        study.subject,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium
                                            ?.copyWith(
                                                color: AppColors.primaryMain),
                                      ),
                                      study.teacher != null ? Text(
                                        study.teacher!.getFio(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: AppColors.textHelper),
                                      ) : const SizedBox(),
                                    ],
                                  ),
                                  if (rightSlot != null) rightSlot!
                                ],
                              ),
                              if (bottomSlot != null) bottomSlot!
                            ],
                          )),
                    ))
              ],
            ))));
  }
}
