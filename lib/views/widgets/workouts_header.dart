import 'package:flutter/material.dart';

class WorkoutsHeader extends StatelessWidget {
  const WorkoutsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentHour = DateTime.now().hour;

    final bool isDayTime = currentHour >= 6 && currentHour < 18;

    final IconData weatherIcon = isDayTime
        ? Icons.wb_sunny_outlined
        : Icons.nightlight_outlined;

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Workouts',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            children: [
              Icon(
                weatherIcon,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              const Text(
                '9°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}