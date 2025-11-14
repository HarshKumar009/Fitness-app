import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/navigation_controller.dart';

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    return Container(
      height: 90,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            ref: ref,
            icon: Icons.spa_outlined,
            label: 'Nutrition',
            index: 0,
            selectedIndex: selectedIndex,
          ),
          _buildNavItem(
            ref: ref,
            icon: Icons.calendar_today_outlined,
            label: 'Plan',
            index: 1,
            selectedIndex: selectedIndex,
          ),
          _buildNavItem(
            ref: ref,
            icon: Icons.mood_outlined,
            label: 'Mood',
            index: 2,
            selectedIndex: selectedIndex,
          ),
          _buildNavItem(
            ref: ref,
            icon: Icons.person_outline,
            label: 'Profile',
            index: 3,
            selectedIndex: selectedIndex,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required WidgetRef ref,
    required IconData icon,
    required String label,
    required int index,
    required int selectedIndex,
  }) {
    final bool isSelected = index == selectedIndex;
    final Color activeColor = Colors.white;
    final Color inactiveColor = Color(0xFF66667E);
    final Color indicatorColor = const Color(0xFF8A8A9E);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(navigationIndexProvider.notifier).state = index;
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? activeColor : inactiveColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 5,
                width: 70,
                decoration: BoxDecoration(
                  color: isSelected ? indicatorColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}