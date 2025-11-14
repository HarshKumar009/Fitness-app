import 'package:evencir_task/views/widgets/calendar_view.dart';
import 'package:evencir_task/views/widgets/calories_card.dart';
import 'package:evencir_task/views/widgets/custom_app_bar.dart';
import 'package:evencir_task/views/widgets/hydration_card.dart';
import 'package:evencir_task/views/widgets/weight_card.dart';
import 'package:evencir_task/views/widgets/workout_card.dart';
import 'package:evencir_task/views/widgets/workouts_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const CalendarView(),
              const WorkoutsHeader(),
              const WorkoutCard(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  'My Insights',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Row(
                  children: const [
                    Expanded(child: CaloriesCard()),
                    SizedBox(width: 16),
                    Expanded(child: WeightCard()),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: const HydrationCard(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}