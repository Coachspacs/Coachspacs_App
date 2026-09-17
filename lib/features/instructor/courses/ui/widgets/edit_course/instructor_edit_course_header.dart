import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorEditCourseHeader extends StatelessWidget {
  const InstructorEditCourseHeader({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2EBE8),
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Icon(
                Icons.arrow_back_rounded,
                size: 21,
                color: Color(0xFF073F38),
              ),
            ),
          ),

          const SizedBox(width: 8),

          Text(
            'Edit Course',
            style: GoogleFonts.inter(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}