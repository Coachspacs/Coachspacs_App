import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/instructor_student_progress.dart';

class InstructorStudentQuizScoresCard
    extends StatelessWidget {
  const InstructorStudentQuizScoresCard({
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
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // =====================================================
          // TITLE
          // =====================================================

          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F5F0),
                  borderRadius:
                  BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.assignment_outlined,
                  size: 19,
                  color: Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 10),

              Text(
                'Quiz Scores',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color:
                  const Color(0xFF073F38),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // =====================================================
          // QUIZZES
          // =====================================================

          for (int index = 0;
          index < student.quizScores.length;
          index++) ...[
            _QuizScoreItem(
              quiz: student.quizScores[index],
            ),

            if (index !=
                student.quizScores.length - 1)
              const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

// =============================================================
// QUIZ ITEM
// =============================================================

class _QuizScoreItem
    extends StatelessWidget {
  const _QuizScoreItem({
    required this.quiz,
  });

  final InstructorStudentQuizScore quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF9),
        borderRadius:
        BorderRadius.circular(11),
        border: Border.all(
          color: const Color(0xFFE4ECE9),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              quiz.title,
              maxLines: 2,
              overflow:
              TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 8.5,
                fontWeight: FontWeight.w600,
                color:
                const Color(0xFF445752),
              ),
            ),
          ),

          const SizedBox(width: 8),

          Text(
            '${quiz.score}/100',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0A8A6C),
            ),
          ),
        ],
      ),
    );
  }
}