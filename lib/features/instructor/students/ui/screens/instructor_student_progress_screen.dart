import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import '../../data/models/instructor_student_progress.dart';

import '../widgets/student_progress/instructor_student_profile_card.dart';
import '../widgets/student_progress/instructor_student_progress_header.dart';
import '../widgets/student_progress/instructor_student_course_progress_card.dart';
import '../widgets/student_progress/instructor_student_quiz_scores_card.dart';
import '../widgets/student_progress/instructor_student_certificate_button.dart';

class InstructorStudentProgressScreen
    extends StatelessWidget {
  const InstructorStudentProgressScreen({
    super.key,
    required this.student,
  });

  final InstructorStudentProgress student;

  // =========================================================
  // ISSUE CERTIFICATE
  // =========================================================

  void _issueCertificate(BuildContext context) {
    // The student must complete the course first.
    if (!student.canIssueCertificate) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'The student must complete the course before a certificate can be issued.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Issue Course Certificate',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: Color(0xFF073F38),
            ),
          ),
          content: Text(
            'Are you sure you want to issue a certificate to '
                '${student.name} for completing ${student.courseName}?',
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Color(0xFF687772),
            ),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(
            16,
            0,
            16,
            14,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF687772),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                _showCertificateSuccess(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF075E4D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Issue Certificate',
                style: TextStyle(

                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // SUCCESS MESSAGE
  // =========================================================

  void _showCertificateSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              color: Colors.white,
              size: 20,
            ),

            SizedBox(width: 9),

            Expanded(
              child: Text(
                'Certificate issued successfully.',
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF075E4D),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            InstructorStudentProgressHeader(
              onBack: () {
                Navigator.pop(context);
              },
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  14,
                  16,
                  24,
                ),
                child: Column(
                  children: [
                    // =================================================
                    // STUDENT
                    // =================================================

                    InstructorStudentProfileCard(
                      student: student,
                    ),

                    const SizedBox(height: 14),

                    // =================================================
                    // COURSE PROGRESS
                    // =================================================

                    InstructorStudentCourseProgressCard(
                      student: student,
                    ),

                    const SizedBox(height: 14),

                    // =================================================
                    // QUIZ SCORES
                    // =================================================

                    InstructorStudentQuizScoresCard(
                      student: student,
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // CERTIFICATE
                    // =================================================

                    InstructorStudentCertificateButton(
                      student: student,
                      onPressed: () {
                        _issueCertificate(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}