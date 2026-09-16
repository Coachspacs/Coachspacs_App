import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/instructor_student_progress.dart';

class InstructorStudentProfileCard
    extends StatelessWidget {
  const InstructorStudentProfileCard({
    super.key,
    required this.student,
  });

  final InstructorStudentProgress student;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Column(
        children: [
          // =====================================================
          // AVATAR
          // =====================================================

          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFF075E4D),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              student.initials,
              style: GoogleFonts.inter(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // =====================================================
          // NAME
          // =====================================================

          Text(
            student.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 4),

          // =====================================================
          // ENROLLED DATE
          // =====================================================

          Text(
            'Enrolled ${student.enrolledDate}',
            style: GoogleFonts.inter(

              fontSize: 10.5,
              color: const Color(0xFF7C8B87),
            ),
          ),

          const SizedBox(height: 9),

          // =====================================================
          // STATUS
          // =====================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE5F7F0),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFC7EBDD),
              ),
            ),
            child: Text(
              student.status,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF168261),
              ),
            ),
          ),
        ],
      ),
    );
  }
}