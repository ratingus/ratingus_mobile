getDayOfWeek(int dayOfWeek) { // пятница
  final now = DateTime.now();
  final currentDayOfWeek = now.weekday; // среда
  final difference = dayOfWeek - currentDayOfWeek; // 5 - 3 = 2
  return now.add(Duration(days: difference)); // 2 дня вперед
}