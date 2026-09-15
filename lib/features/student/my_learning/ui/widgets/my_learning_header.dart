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
            fontSize: 21,
            height: 1.2,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),
      ],
    );
  }
}