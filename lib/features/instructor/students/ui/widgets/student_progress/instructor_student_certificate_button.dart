


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/instructor_student_progress.dart';

class InstructorStudentCertificateButton
    extends StatelessWidget {
  const InstructorStudentCertificateButton({
    super.key,
    required this.student,
    required this.onPressed,
  });

  final InstructorStudentProgress student;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final canIssue =
        student.canIssueCertificate;

    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: canIssue ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
          const Color(0xFF075E4D),
          disabledBackgroundColor:
          const Color(0xFFDCE7E4),
          foregroundColor: Colors.white,
          disabledForegroundColor:
          const Color(0xFF879691),
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12),
          ),
        ),
        child: Text(
          canIssue
              ? 'Issue Course Certificate'
              : 'Certificate Unavailable',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}