import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoadmapBanner extends StatelessWidget {
  const RoadmapBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 208,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE3F5F2),
            Color(0xFFBFE6DA),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Positioned(
              top: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '✦',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFF2B938),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'AI Guided Roadmap',


                      style: GoogleFonts.inter(
                        color: const Color(0xFF075E4D),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 14,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF247A60),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 4,
                      backgroundColor: Color(0xFF8BE0C4),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Active Plan',


                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Mountains
            Positioned(
              left: -20,
              right: -20,
              bottom: 52,
              child: CustomPaint(
                size: const Size(double.infinity, 100),
                painter: _MountainPainter(),
              ),
            ),

            // Road
            Positioned(
              left: 42,
              right: 70,
              bottom: 17,
              child: CustomPaint(
                size: const Size(double.infinity, 70),
                painter: _RoadPainter(),
              ),
            ),

            // Destination sun
            Positioned(
              right: 65,
              top: 30,
              child: Container(
                width: 78,
                height: 78,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD98A),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Flag
            const Positioned(
              right: 83,
              top: 56,
              child: Icon(
                Icons.flag,
                color: Color(0xFFF0A91C),
                size: 30,
              ),
            ),

            // Step 1
            const Positioned(
              left: 58,
              bottom: 31,
              child: _StepNumber(number: '1'),
            ),

            // Step 2
            const Positioned(
              left: 177,
              bottom: 60,
              child: _StepNumber(number: '2'),
            ),

            // Step 3
            const Positioned(
              right: 83,
              top: 68,
              child: _StepNumber(number: '3'),
            ),

            // AI icon
            Positioned(
              left: 39,
              top: 82,
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .85),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.smart_toy_outlined,
                  color: Color(0xFF075E4D),
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepNumber extends StatelessWidget {
  final String number;

  const _StepNumber({
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        number,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF075E4D),
        ),
      ),
    );
  }
}

class _MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFB8DED3)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width * .20, size.height * .25);
    path.lineTo(size.width * .34, size.height * .55);
    path.lineTo(size.width * .55, size.height * .05);
    path.lineTo(size.width * .78, size.height * .62);
    path.lineTo(size.width, size.height * .25);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final line = Paint()
      ..color = const Color(0xFF075E4D)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(0, size.height);
    path.cubicTo(
      size.width * .15,
      size.height * .15,
      size.width * .55,
      size.height * .85,
      size.width,
      0,
    );

    canvas.drawPath(path, road);
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
