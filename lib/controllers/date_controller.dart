import 'package:flutter_riverpod/legacy.dart';

class DateNotifier extends StateNotifier<DateTime> {
  DateNotifier() : super(DateTime.now());

  void updateDate(DateTime newDate) {
    state = newDate;
  }
}

final dateProvider = StateNotifierProvider<DateNotifier, DateTime>((ref) {
  return DateNotifier();
});

int getWeekOfMonth(DateTime date) {
  final firstDayOfMonth = DateTime(date.year, date.month, 1);
  final firstDayOfWeek = firstDayOfMonth.weekday;
  final offset = (firstDayOfWeek - 1);
  // Calculate week number
  return ((date.day + offset - 1) / 7).floor() + 1;
}

int getTotalWeeksInMonth(DateTime date) {
  final firstDay = DateTime(date.year, date.month, 1);
  final lastDay = DateTime(date.year, date.month + 1, 0);
  final totalDays = lastDay.day;
  final firstDayOffset = firstDay.weekday - 1;
  return ((totalDays + firstDayOffset) / 7).ceil();
}