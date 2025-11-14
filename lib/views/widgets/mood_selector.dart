import 'dart:math';
import 'package:flutter/material.dart';

class Mood {
  final String label;
  final String emojiAsset;

  const Mood({
    required this.label,
    required this.emojiAsset,
  });
}

// Mood Selector Widget
class MoodSelector extends StatefulWidget {
  final Function(Mood) onMoodChanged;

  const MoodSelector({super.key, required this.onMoodChanged});

  @override
  MoodSelectorState createState() => MoodSelectorState();
}

class MoodSelectorState extends State<MoodSelector> {
  final List<Color> _segmentColors = const [
    Color(0xFFFF9966),
    Color(0xFF66D9CF),
    Color(0xFFFF85B8),
    Color(0xFFC8B6FF),
  ];

  final List<Mood> _moods = const [
    Mood(label: 'Happy', emojiAsset: 'assets/emojis/happy.png'),
    Mood(label: 'Calm', emojiAsset: 'assets/emojis/calm.png'),
    Mood(label: 'Peaceful', emojiAsset: 'assets/emojis/peaceful.png'),
    Mood(label: 'Content', emojiAsset: 'assets/emojis/content.png'),
  ];

  double _currentAngle = 0;
  int _currentIndex = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      moveToMood(3, animate: false);
    });
  }

  void moveToNextMood() {
    int nextIndex = (_currentIndex + 1) % _moods.length;
    moveToMood(nextIndex);
  }

  void moveToMood(int index, {bool animate = true}) {
    final segmentAngle = (2 * pi) / 4;
    final centerAngle = -pi / 2 + (segmentAngle / 2) + (index * segmentAngle);

    setState(() {
      _currentIndex = index;
      _currentAngle = centerAngle;
      widget.onMoodChanged(_moods[_currentIndex]);
    });
  }

  void _handlePanUpdate(DragUpdateDetails details, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final touchPosition = details.localPosition;
    final angle = atan2(touchPosition.dy - center.dy, touchPosition.dx - center.dx);

    double normalizedAngle = angle + pi / 2;
    if (normalizedAngle < 0) {
      normalizedAngle += 2 * pi;
    }

    int index = (normalizedAngle / (2 * pi / _moods.length)).floor();
    index = index % _moods.length;

    if (_currentIndex != index) {
      moveToMood(index);
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    moveToMood(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.55;
    final currentMood = _moods[_currentIndex];

    return GestureDetector(
      onPanUpdate: (details) => _handlePanUpdate(details, Size(size, size)),
      onPanEnd: _handlePanEnd,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _MoodCirclePainter(
              segmentColors: _segmentColors,
              handleAngle: _currentAngle,
            ),
          ),
          SizedBox(
            width: size * 0.45,
            height: size * 0.45,
            child: Image.asset(currentMood.emojiAsset, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}

class _MoodCirclePainter extends CustomPainter {
  final List<Color> segmentColors;
  final double handleAngle;

  _MoodCirclePainter({required this.segmentColors, required this.handleAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final strokeWidth = radius * 0.20;

    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    final sweepAngle = (2 * pi) / 4;
    final startAngle = -pi / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    for (int i = 0; i < segmentColors.length; i++) {
      paint.color = segmentColors[i];
      canvas.drawArc(
        rect,
        startAngle + (i * sweepAngle),
        sweepAngle,
        false,
        paint,
      );
    }

    final handleRadius = strokeWidth * 0.45;
    final arcCenterRadius = radius - strokeWidth / 2;

    final handleCenter = Offset(
      center.dx + arcCenterRadius * cos(handleAngle),
      center.dy + arcCenterRadius * sin(handleAngle),
    );

    final handleGlowPaint = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
    canvas.drawCircle(handleCenter, handleRadius * 1.4, handleGlowPaint);

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);
    canvas.drawCircle(
        handleCenter + const Offset(0.5, 1),
        handleRadius,
        shadowPaint
    );

    final handlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(handleCenter, handleRadius, handlePaint);

    final handleGradientPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFFFFFF),
          const Color(0xFFF8F8F8),
        ],
        center: Alignment.topLeft,
        radius: 1.0,
      ).createShader(Rect.fromCircle(center: handleCenter, radius: handleRadius));
    canvas.drawCircle(handleCenter, handleRadius, handleGradientPaint);

    final handleBorderPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawCircle(handleCenter, handleRadius, handleBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}