import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

class ContinueLearningSection extends StatelessWidget {
  const ContinueLearningSection({
    super.key,
    required this.enrollments,
  });

  final List<EnrollmentDto> enrollments;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (enrollments.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFE7F5F0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          l10n.myLearningNoProgress,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: const Color(0xFF42645C),
          ),
        ),
      );
    }

    final enrollment = enrollments.firstWhere(
      (e) => !e.isCompleted,
      orElse: () => enrollments.first,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 17, 20, 18),
      decoration: BoxDecoration(
        color: const Color(0xFF075E4D),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF075E4D).withValues(alpha: .12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '✦',
                style: TextStyle(fontSize: 13, color: Color(0xFF65D5B3)),
              ),
              const SizedBox(width: 7),
              Text(
                l10n.myLearningContinueSection.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .8,
                  color: const Color(0xFF76D9BD),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            enrollment.course.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 19,
              height: 1.25,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            enrollment.isCompleted
                ? l10n.myLearningCourseCompleted
                : l10n.myLearningContinueWhereLeft,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFFA9D5C8),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.courseDetails,
                  arguments: enrollment.course.id,
                );
              },
              icon: const Icon(
                Icons.play_arrow_rounded,
                size: 15,
                color: Color(0xFF073F38),
              ),
              label: Text(
                l10n.myLearningContinue,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF073F38),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF073F38),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 17),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
