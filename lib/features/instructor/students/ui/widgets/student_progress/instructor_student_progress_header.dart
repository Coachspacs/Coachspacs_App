import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorStudentProgressHeader
    extends StatelessWidget {
  const InstructorStudentProgressHeader({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
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
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 38,
              minHeight: 38,
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 21,
              color: Color(0xFF263C38),
            ),
          ),

          const SizedBox(width: 5),

          Text(
            'Student Progress',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}