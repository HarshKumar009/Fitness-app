import 'package:evencir_task/models/workout_model.dart';
import 'package:flutter/material.dart';

class WorkoutItemCard extends StatelessWidget {
  final Workout workout;
  const WorkoutItemCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Draggable<Workout>(
      data: workout,
      feedback: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9 - 72,
        child: Material(
          color: Colors.transparent,
          child: Opacity(opacity: 0.8, child: _buildCardContent()),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: _buildCardContent()),
      child: _buildCardContent(),
    );
  }

  Widget _buildDragHandleIcon() {
    return SizedBox(
      width: 16,
      height: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (_) =>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(2, (_) =>
                  Container(
                    width: 4, height: 4,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade600),
                  )
              ),
            )
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    final bool isArms = workout.type == WorkoutType.arms;
    final Color tagColor = isArms ? const Color(0xFF1E4239) : const Color(0xFF2D3B5B);
    final Color tagTextColor = isArms ? const Color(0xFF67C4A7) : const Color(0xFF5A84C4);
    final IconData tagIcon = isArms ? Icons.sports_gymnastics : Icons.directions_run;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF18181C),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDragHandleIcon(),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(tagIcon, color: tagTextColor, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            workout.title,
                            style: TextStyle(color: tagTextColor, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            workout.subTitle,
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          workout.duration,
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: Container(
            width: 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}