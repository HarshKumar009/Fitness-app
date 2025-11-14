import 'package:evencir_task/views/mood_screen.dart';
import 'package:evencir_task/views/training_calendar_screen.dart';
import 'package:evencir_task/views/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/navigation_controller.dart';
import 'home_screen.dart';


class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    TrainingCalendarScreen(),
    MoodScreen(),
    Scaffold(body: Center(child: Text('Profile Screen'))),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      body: IndexedStack(
        index: currentIndex,
        children: _screens,
      ),
    );
  }
}