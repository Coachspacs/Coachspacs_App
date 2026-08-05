// this file was create with AI !!! ()
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

class SignupBottomWavesPainter extends CustomPainter {
  const SignupBottomWavesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Light Green Gradient Wave (#D1FAE5)
    final pathLight = Path();
    pathLight.moveTo(0, size.height * 0.28);

    // Smooth curve 1: left valley to first crest
    pathLight.cubicTo(
      size.width * 0.12,
      size.height * 0.68,
      size.width * 0.26,
      size.height * 0.22,
      size.width * 0.40,
      size.height * 0.30,
    );

    // Smooth curve 2: middle valley to right edge
    pathLight.cubicTo(
      size.width * 0.54,
      size.height * 0.38,
      size.width * 0.68,
      size.height * 0.82,
      size.width,
      size.height * 0.25,
    );

    pathLight.lineTo(size.width, size.height);
    pathLight.lineTo(0, size.height);
    pathLight.close();

    final paintLight = Paint()
      ..isAntiAlias = true
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFD1FAE5), Color(0x808BEDC3)],
        stops: [0.25, 0.86],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(pathLight, paintLight);

    // 2. Dark Green Wave (#0F5244)
    final pathDark = Path();
    pathDark.moveTo(0, size.height * 0.48);

    // Smooth curve 1: left valley to first crest
    pathDark.cubicTo(
      size.width * 0.12,
      size.height * 0.72,
      size.width * 0.26,
      size.height * 0.46,
      size.width * 0.40,
      size.height * 0.54,
    );

    // Smooth curve 2: deep middle valley to right edge
    pathDark.cubicTo(
      size.width * 0.54,
      size.height * 0.62,
      size.width * 0.68,
      size.height * 0.92,
      size.width,
      size.height * 0.48,
    );

    pathDark.lineTo(size.width, size.height);
    pathDark.lineTo(0, size.height);
    pathDark.close();

    final paintDark = Paint()
      ..isAntiAlias = true
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    canvas.drawPath(pathDark, paintDark);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}