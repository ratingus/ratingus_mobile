import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/study/model/day_with_studies.dart';

class StudyListView<Day extends DayWithStudies<Study>, Study>
    extends StatelessWidget {
  final List<Day> list;
  final Function(Day)? renderDay;
  final Function(Study, Day, int) renderItem;

  const StudyListView(
      {super.key,
      required this.list,
      this.renderDay,
      required this.renderItem});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        itemBuilder: (BuildContext dayContext, int dayIndex) {
          final currentDay = list[dayIndex];
          return Card(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: renderDay?.call(list[dayIndex]),
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return renderItem(currentDay.studies[index], currentDay, index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 10.0,
                              color: Colors.transparent,
                            );
                          },
                          itemCount: currentDay.studies.length)
                    ],
                  )));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 10.0,
            color: Colors.transparent,
          );
        },
        itemCount: list.length);
  }
}
