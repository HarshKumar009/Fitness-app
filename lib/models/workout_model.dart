
enum WorkoutType { arms, legs }

class Workout {
  final String id;
  final String title;
  final String subTitle;
  final WorkoutType type;
  final String duration;

  const Workout({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.type,
    required this.duration,
  });
}