import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/class/ui/class_item.dart';
import 'package:ratingus_mobile/entity/school/model/school.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class SchoolTabs extends StatefulWidget {
  final List<School> schools;

  const SchoolTabs({super.key, required this.schools});

  @override
  State<SchoolTabs> createState() => _SchoolTabsState();
}

class _SchoolTabsState extends State<SchoolTabs>
    with SingleTickerProviderStateMixin {
  int _selectedSchoolIndex = 0; // TODO: прокидывать user.schoolId и искать по нему дефолтный _selectedSchoolIndex
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.schools.length,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              onPressed: () {
                setState(() {
                  AppMetrica.reportEvent('Пользователь сменил школу');
                  _selectedSchoolIndex = index;
                });
              },
              child: Text(
                widget.schools[index].name,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: _selectedSchoolIndex == index
                        ? AppColors.primaryMain
                        : AppColors.textPrimary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.schools[index].role.value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.backgroundMain,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: widget.schools[index].classes.map((classItem) {
                      return ClassListItem(classItem: classItem);
                    }).toList(),
                  ),
                )),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          thickness: 13,
          color: Colors.transparent,
        );
      },
    );
  }
}
