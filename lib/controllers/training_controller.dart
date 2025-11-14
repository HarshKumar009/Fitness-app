import 'package:flutter_riverpod/legacy.dart';
import '../models/workout_model.dart';

class DaySchedule {
  final String dayName;
  final int date;
  Workout? workout;

  DaySchedule({required this.dayName, required this.date, this.workout});
}


class TrainingNotifier extends StateNotifier<List<DaySchedule>> {
  TrainingNotifier() : super(_getInitialSchedule());

  static List<DaySchedule> _getInitialSchedule() {
    return [
      DaySchedule(dayName: 'Mon', date: 8, workout: const Workout(id: 'w1', title: 'Arms Workout', subTitle: 'Arm Blaster', type: WorkoutType.arms, duration: '25m - 30m')),
      DaySchedule(dayName: 'Tue', date: 9),
      DaySchedule(dayName: 'Wed', date: 10),
      DaySchedule(dayName: 'Thu', date: 11, workout: const Workout(id: 'w2', title: 'Leg Workout', subTitle: 'Leg Day Blitz', type: WorkoutType.legs, duration: '25m - 30m')),
      DaySchedule(dayName: 'Fri', date: 12),
      DaySchedule(dayName: 'Sat', date: 13),
      DaySchedule(dayName: 'Sun', date: 14),
    ];
  }

  void moveWorkout(Workout workoutToMove, int newDayDate) {
    final currentState = state;

    final sourceDay = currentState.firstWhere((day) => day.workout?.id == workoutToMove.id);
    final sourceDayIndex = currentState.indexOf(sourceDay);
    currentState[sourceDayIndex] = DaySchedule(dayName: sourceDay.dayName, date: sourceDay.date, workout: null);

    final targetDay = currentState.firstWhere((day) => day.date == newDayDate);
    final targetDayIndex = currentState.indexOf(targetDay);
    currentState[targetDayIndex] = DaySchedule(dayName: targetDay.dayName, date: targetDay.date, workout: workoutToMove);

    state = [...currentState];
  }
}

// Provider
final trainingProvider = StateNotifierProvider<TrainingNotifier, List<DaySchedule>>((ref) {
  return TrainingNotifier();
});