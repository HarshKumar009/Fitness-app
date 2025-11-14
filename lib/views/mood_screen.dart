import 'package:evencir_task/views/widgets/mood_selector.dart';
import 'package:flutter/material.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  Mood? _currentMood;
  final GlobalKey<MoodSelectorState> _moodSelectorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 0.7,
            colors: [
              Color(0xFF2A3A5B),
              Colors.black,
            ],
            stops: [0.0, 0.8],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Mood', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Start your day', style: TextStyle(color: Colors.grey, fontSize: 16)),
                      SizedBox(height: 32),
                      Text('How are you feeling at the Moment?', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)), // Font size thora bara
                    ],
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MoodSelector(
                        key: _moodSelectorKey,
                        onMoodChanged: (mood) {
                          setState(() {
                            _currentMood = mood;
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        child: _currentMood == null
                            ? const SizedBox.shrink()
                            : Text(
                          _currentMood!.label,
                          key: ValueKey<String>(_currentMood!.label),
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),

                // Button Section
                Expanded(
                  flex: 1,
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _moodSelectorKey.currentState?.moveToNextMood();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text('Continue', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}