import 'package:flutter/material.dart';

class MyPathGoalRoadmap extends StatelessWidget {
  const MyPathGoalRoadmap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE5F7F1),
            Color(0xFFCFEADF),
          ],
        ),
        border: Border.all(
          color: const Color(0xFFD2EEE5),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 14,
            left: 14,
            child: _RoadmapBadge(
              icon: Icons.auto_awesome,
              text: 'AI Guided Roadmap',
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: _RoadmapBadge(
              icon: Icons.circle,
              text: 'Active Plan',
              dark: true,
            ),
          ),

          // Background hills
          Positioned(
            left: -30,
            right: -30,
            bottom: 35,
            child: Container(
              height: 75,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(100),
                ),
                color: Color(0xFF7FC09F),
              ),
            ),
          ),
          Positioned(
            left: -40,
            right: -40,
            bottom: -10,
            child: Container(
              height: 75,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(100),
                ),
                color: Color(0xFF3E9671),
              ),
            ),
          ),

          // Road
          Positioned(
            left: 40,
            right: 55,
            bottom: 54,
            child: CustomPaint(
              size: const Size(double.infinity, 65),
              painter: _RoadPainter(),
            ),
          ),

          const Positioned(
            left: 60,
            bottom: 42,
            child: _NumberPoint(number: '1'),
          ),
          const Positioned(
            left: 185,
            bottom: 83,
            child: _NumberPoint(number: '2'),
          ),
          const Positioned(
            right: 60,
            bottom: 125,
            child: _NumberPoint(number: '3'),
          ),

          Positioned(
            top: 44,
            right: 65,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFD987).withValues(alpha: .75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoadmapBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool dark;

  const _RoadmapBadge({
    required this.icon,
    required this.text,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF17745D) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: dark
            ? null
            : Border.all(
          color: const Color(0xFFD5EDE5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: dark
                ? const Color(0xFFB9F0DB)
                : const Color(0xFF075E4D),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: dark
                  ? Colors.white
                  : const Color(0xFF075E4D),
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberPoint extends StatelessWidget {
  final String number;

  const _NumberPoint({
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        number,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Color(0xFF075E4D),
        ),
      ),
    );
  }
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height)
      ..cubicTo(
        size.width * .18,
        size.height * .15,
        size.width * .40,
        size.height * .85,
        size.width * .58,
        size.height * .40,
      )
      ..cubicTo(
        size.width * .72,
        size.height * .05,
        size.width * .83,
        size.height * .35,
        size.width,
        0,
      );

    final roadPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    final dashedPaint = Paint()
      ..color = const Color(0xFF075E4D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, roadPaint);
    canvas.drawPath(path, dashedPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}