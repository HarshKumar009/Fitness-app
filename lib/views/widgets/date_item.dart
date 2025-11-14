import 'package:flutter/material.dart';

class DateItem extends StatelessWidget {
  final String dayNumber;
  final bool isSelected;

  const DateItem({
    super.key,
    required this.dayNumber,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF20B76F);
    const Color innerGlowGreen = Color(0x3020B76F);

    const Color unselectedColor = Color(0xFF222222);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? innerGlowGreen : unselectedColor,
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: primaryGreen, width: 2)
                : Border.all(color: unselectedColor),
          ),
          child: Center(
            child: Text(
              dayNumber,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: isSelected ? primaryGreen : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}