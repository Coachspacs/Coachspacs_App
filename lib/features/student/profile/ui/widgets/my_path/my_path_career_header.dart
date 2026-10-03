import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPathCareerHeader extends StatelessWidget {
  const MyPathCareerHeader({super.key});

  static const Color primary = Color(0xFF075E4D);
  static const Color darkText = Color(0xFF102A2A);
  static const Color lightGreen = Color(0xFFE7F5F0);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            'Your Career Path',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: darkText,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Personalized',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: primary,
            ),
          ),
        ),
      ],
    );
  }
}