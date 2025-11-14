import 'package:evencir_task/controllers/training_controller.dart';
import 'package:evencir_task/models/workout_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'workout_item_card.dart';

class DayScheduleTile extends ConsumerWidget {
  final DaySchedule day;
  const DayScheduleTile({super.key, required this.day});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        DragTarget<Workout>(
          builder: (context, candidateData, rejectedData) {
            return Container(
              constraints: const BoxConstraints(minHeight: 95),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.dayName,
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          day.date.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: day.workout != null
                        ? WorkoutItemCard(workout: day.workout!)
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            );
          },
          onAccept: (droppedWorkout) {
            if (day.workout == null) {
              ref.read(trainingProvider.notifier).moveWorkout(droppedWorkout, day.date);
            }
          },
        ),

        Padding(
          padding: const EdgeInsets.only(left: 72.0, right: 16.0),
          child: const Divider(color: Color(0xFF2A2A3A), height: 1, thickness: 1),
        ),
      ],
    );
  }
}