import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLearningHeader extends StatelessWidget {
  const MyLearningHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Learning',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Welcome back, Sondos 👋',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF71807C),
          ),
        ),
      ],
    );
  }
}