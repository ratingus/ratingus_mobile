import 'package:flutter/material.dart';
import 'package:ratingus_mobile/shared/theme/consts/colors.dart';

getColorMark(String mark) {
  switch (mark) {
    case '5':
      return AppColors.statusSuccess;
    case '4':
      return AppColors.statusInfo;
    case '3':
      return AppColors.statusCaution;
    case '2':
    case '1':
      return AppColors.statusWarning;
    default:
      return AppColors.textHelper;
  }
}

class LessonMark extends StatelessWidget {
  final String mark;

  const LessonMark({super.key, required this.mark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Оценка: ', style: Theme.of(context).textTheme.displayMedium),
        Text(mark,
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: getColorMark(mark))),
      ],
    );
  }
}
