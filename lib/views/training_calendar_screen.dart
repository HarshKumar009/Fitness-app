import 'package:evencir_task/views/widgets/day_schedule_tile.dart';
import 'package:evencir_task/views/widgets/week_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/training_controller.dart';

class TrainingCalendarScreen extends ConsumerWidget {
  const TrainingCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedule = ref.watch(trainingProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Training Calendar',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(
            color: Color(0xFF4A3A8A),
            height: 3,
            thickness: 5,
          ),
          Expanded(
            child: ListView(
              children: [
                const WeekHeader(),
                ...schedule.map((day) => DayScheduleTile(day: day)).toList(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}