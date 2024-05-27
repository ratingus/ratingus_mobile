import 'package:intl/intl.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';

getDayOfWeek(int dayOfWeek) {
  // пятница
  final now = DateTime.now();
  final currentDayOfWeek = now.weekday; // среда
  final difference = dayOfWeek - currentDayOfWeek; // 5 - 3 = 2
  return now.add(Duration(days: difference)); // 2 дня вперед
}

getDayMonth(DateTime date) {
  final formatDay = DateFormat('d');
  final formatMonth = DateFormat('MMM', 'ru_RU');
  return '${formatDay.format(date)} ${capitalize(formatMonth.format(date))}';
}

String getStringOfWeek(DateTime date) {
  final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
  final endOfWeek = startOfWeek.add(const Duration(days: 6));

  final formatDay = DateFormat('d');
  final formatMonth = DateFormat('MMM', 'ru_RU');

  final isMonthDifferent = startOfWeek.month != endOfWeek.month;

  final startString =
      '${formatDay.format(startOfWeek)}${isMonthDifferent ? ' ${capitalize(formatMonth.format(startOfWeek))}' : ''}';
  final endString = '${getDayMonth(endOfWeek)}';

  return '$startString - $endString';
}

DateTime getAcademicDateByWeek(int weekOfYear) {
  final date = getAcademicDate(DateTime.now());
  final difference = (weekOfYear - 1) * 7;
  return date.add(Duration(days: difference));
}

int getAcademicWeekOfYear(DateTime date) {
  int weekOfYear = ((date.difference(getAcademicDate(date)).inDays) / 7).ceil() + 1;

  return weekOfYear;
}

DateTime getAcademicDate(DateTime date) {
  DateTime startOfAcademicDate = DateTime(date.year, 9, 1);
  startOfAcademicDate.add(Duration(days: -startOfAcademicDate.weekday + 1));

  if (date.add(const Duration(days: 7)).isBefore(startOfAcademicDate)) {
    startOfAcademicDate = DateTime(date.year - 1, 9, 1);
    startOfAcademicDate.add(Duration(days: -startOfAcademicDate.weekday + 1));
  }
  return startOfAcademicDate;
}
