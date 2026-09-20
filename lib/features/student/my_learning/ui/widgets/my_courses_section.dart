import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

class MyCoursesSection extends StatelessWidget {
  const MyCoursesSection({
    super.key,
    required this.enrollments,
  });

  final List<EnrollmentDto> enrollments;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              l10n.myLearningMyCourses,
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.browseCourses);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                l10n.myLearningViewAll,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (enrollments.isEmpty)
          _EmptyCoursesCard()
        else
          ...enrollments.take(3).map(
            (enrollment) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _LearningCourseCard(
                title: enrollment.course.title,
                progress: enrollment.progressPercent / 100,
                progressPercent: enrollment.progressPercent,
                statusLabel: enrollment.isCompleted
                    ? l10n.myLearningCourseCompleted
                    : '${enrollment.progressPercent}% '
                          '${l10n.myLearningInProgressFooter.toLowerCase()}',
                onContinue: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.courseDetails,
                    arguments: enrollment.course.id,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _LearningCourseCard extends StatelessWidget {
  const _LearningCourseCard({
    required this.title,
    required this.progress,
    required this.progressPercent,
    required this.statusLabel,
    required this.onContinue,
  });

  final String title;
  final double progress;
  final int progressPercent;
  final String statusLabel;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFDDEBE6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 13,
              height: 1.25,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF073F38),
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0, 1),
                    minHeight: 7,
                    backgroundColor: const Color(0xFFE9F0EE),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF075E4D),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$progressPercent%',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Expanded(
                child: Text(
                  statusLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: const Color(0xFF8A9A96),
                  ),
                ),
              ),
              TextButton(
                onPressed: onContinue,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  '${context.l10n.myLearningContinue} →',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF073F38),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyCoursesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFDDEBE6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.myLearningNoCourses,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3E5A54),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            context.l10n.myLearningBrowseHint,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF7D8D89),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 36,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.catalog);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E4D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                context.l10n.myLearningBrowseCourses,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
