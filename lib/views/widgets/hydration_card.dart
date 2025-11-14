import 'package:flutter/material.dart';

class HydrationCard extends StatelessWidget {
  const HydrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color cardBackgroundColor = Color(0xFF222222);
    const Color percentageColor = Color(0xFF48A4E5);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        color: cardBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Row(
                  children: [
                    // Left Side Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '0%',
                          style: TextStyle(
                            color: percentageColor,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'Hydration',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Log Now',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const _WaterRuler(),
                  ],
                ),
              ),
            ),
            const _LogButton(),
          ],
        ),
      ),
    );
  }
}

// _LogButton waisa hi rahega
class _LogButton extends StatelessWidget {
  const _LogButton();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1B3D45),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const Center(
        child: Text(
          '500 ml added to water log',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class _WaterRuler extends StatelessWidget {
  const _WaterRuler();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Text('2 L', style: TextStyle(color: Colors.grey.shade400)),
          ),
          Positioned(
            bottom: 22,
            left: 0,
            child: Text('0 L', style: TextStyle(color: Colors.grey.shade400)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text('0ml', style: TextStyle(color: Colors.grey.shade400, fontSize: 16)),
          ),

          Positioned.fill(
            left: 35,
            right: 10,
            child: CustomPaint(
              painter: _WaterRulerPainter(),
            ),
          ),
        ],
      ),
    );
  }
}


class _WaterRulerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()..color = const Color(0xFF48A4E5);
    final greyDashPaint = Paint()..color = Colors.grey.shade700;
    final greyLinePaint = Paint()
      ..color = Colors.grey.shade600
      ..strokeWidth = 1.5;

    // Dimensions
    const markerWidth = 15.0;
    const markerHeight = 5.0;
    final rrectRadius = Radius.circular(markerHeight / 2);

    final startY = markerHeight / 2;
    final endY = size.height - 25;
    final rulerHeight = endY - startY;
    const centerX = markerWidth / 2;


    final horizontalLineY = endY;
    final horizontalLineStartX = centerX;
    final horizontalLineEndX = size.width;
    canvas.drawLine(Offset(horizontalLineStartX, horizontalLineY), Offset(horizontalLineEndX, horizontalLineY), greyLinePaint);

    final topRRect = RRect.fromLTRBR(0, 0, markerWidth, markerHeight, rrectRadius);
    final bottomRRect = RRect.fromLTRBR(0, endY - markerHeight / 2, markerWidth, endY + markerHeight / 2, rrectRadius);
    canvas.drawRRect(topRRect, bluePaint);
    canvas.drawRRect(bottomRRect, bluePaint);

    const totalSegments = 10;
    final stepY = rulerHeight / totalSegments;

    for (int i = 1; i < totalSegments; i++) {
      final y = startY + (i * stepY);

      if (i == 7) {
        final midMarkerRRect = RRect.fromLTRBR(0, y - markerHeight/2, markerWidth, y + markerHeight/2, rrectRadius);
        canvas.drawRRect(midMarkerRRect, bluePaint);
      } else {
        const dashWidth = 5.0;
        const dashHeight = 2.0;
        final dashRect = Rect.fromCenter(center: Offset(centerX, y), width: dashWidth, height: dashHeight);
        canvas.drawRect(dashRect, greyDashPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}