import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../controllers/date_controller.dart';
import 'date_item.dart';

class CalendarView extends ConsumerWidget {
  const CalendarView({super.key});

  List<DateTime> _getDaysInWeek(DateTime selectedDate) {
    DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  String _formatDisplayDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final selectedDay = DateTime(date.year, date.month, date.day);

    if (selectedDay == today) {
      return "Today, ${DateFormat('d MMM yyyy').format(date)}";
    } else {
      return DateFormat('EEEE, d MMM yyyy').format(date);
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(dateProvider);

    final List<DateTime> weekDays = _getDaysInWeek(selectedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatDisplayDate(selectedDate),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: weekDays.map((date) {
              final dayName = DateFormat.E(Localizations.localeOf(context).toString()).format(date).toUpperCase();
              final dayNumber = date.day.toString();

              final isSelected = date.year == selectedDate.year &&
                  date.month == selectedDate.month &&
                  date.day == selectedDate.day;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    ref.read(dateProvider.notifier).updateDate(date);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dayName,
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),

                        DateItem(
                          dayNumber: dayNumber,
                          isSelected: isSelected,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}