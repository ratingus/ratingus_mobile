import 'package:flutter/material.dart';
import 'package:ratingus_mobile/entity/class/model/class_model.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

class ClassListItem extends StatelessWidget {
  final ClassItem classItem;

  const ClassListItem({super.key, required this.classItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryMain,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            classItem.name,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: AppColors.primaryPaper),
          ),
        ),
      ),
    );
  }
}
