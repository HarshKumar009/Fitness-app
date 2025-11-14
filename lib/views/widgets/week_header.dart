import 'package:flutter/material.dart';

class WeekHeader extends StatelessWidget {
  const WeekHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: const Color(0xFF121212),
      ),
      child: Padding(

        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Week 2/8',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'December 8-14',
                  style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
                ),
                Text(
                  'Total: 60min',
                  style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}