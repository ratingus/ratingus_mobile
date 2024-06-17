import 'package:intl/intl.dart';
import 'package:ratingus_mobile/shared/helpers/strings.dart';

getDayOfWeek(int dayOfWeek) {
  // пятница
  final now = DateTime.now();
  final currentDayOfWeek = now.weekday; // среда
  final difference = dayOfWeek - currentDayOfWeek; // 5 - 3 = 2
  return now.add(Duration(days: difference)); // 2 дня вперед
}

String getMonthInGenitiveCase(int month) {
  switch (month) {
    case 1:
      return 'января';
    case 2:
      return 'февраля';
    case 3:
      return 'марта';
    case 4:
      return 'апреля';
    case 5:
      return 'мая';
    case 6:
      return 'июня';
    case 7:
      return 'июля';
    case 8:
      return 'августа';
    case 9:
      return 'сентября';
    case 10:
      return 'октября';
    case 11:
      return 'ноября';
    case 12:
      return 'декабря';
    default:
      return '';
  }
}

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day &&
      date1.hour == date2.hour &&
      date1.minute == date2.minute &&
      date1.second == date2.second;
}

String getDayMonth(DateTime date) {
  final formatDay = DateFormat('d');
  final month = capitalize(getMonthInGenitiveCase(date.month));
  return '${formatDay.format(date)} $month';
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
  int weekOfYear =
      ((date.difference(getAcademicDate(date)).inDays) / 7).ceil() + 1;

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
