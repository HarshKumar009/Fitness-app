import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controllers/date_controller.dart';

class CalendarViewBottomsheet extends ConsumerStatefulWidget {
  const CalendarViewBottomsheet({super.key});

  @override
  ConsumerState<CalendarViewBottomsheet> createState() => _CalendarViewBottomsheetState();
}

class _CalendarViewBottomsheetState extends ConsumerState<CalendarViewBottomsheet> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = ref.read(dateProvider);
    _focusedDay = _selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF20B76F);
    const Color innerGlowGreen = Color(0x3020B76F);
    const Color unselectedColor = Color(0xFF222222);
    final Color sheetBackgroundColor = Colors.grey.shade900;

    return Container(
      decoration: BoxDecoration(
        color: sheetBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              currentDay: _selectedDay,
              calendarFormat: CalendarFormat.month,
              startingDayOfWeek: StartingDayOfWeek.monday,

              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                ref.read(dateProvider.notifier).updateDate(selectedDay);
                Navigator.pop(context);
              },

              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },

              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
                leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
                rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: Colors.grey.shade400),
                weekendStyle: TextStyle(color: Colors.grey.shade400),
              ),
              calendarStyle: CalendarStyle(
                // Text Styles
                defaultTextStyle: const TextStyle(color: Colors.white),
                weekendTextStyle: const TextStyle(color: Colors.white),
                outsideTextStyle: TextStyle(color: Colors.grey.shade600),
                selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                todayTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),

                defaultDecoration: const BoxDecoration(
                  color: unselectedColor,
                  shape: BoxShape.circle,
                ),
                weekendDecoration: const BoxDecoration(
                  color: unselectedColor,
                  shape: BoxShape.circle,
                ),
                outsideDecoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),

                selectedDecoration: BoxDecoration(
                  color: innerGlowGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryGreen, width: 2),
                ),

                todayDecoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryGreen, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}