import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

class MyLearningStats extends StatelessWidget {
  const MyLearningStats({
    super.key,
    required this.enrollments,
  });

  final List<EnrollmentDto> enrollments;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final enrolledCount = enrollments.length;
    final completedCount = enrollments
        .where((enrollment) => enrollment.isCompleted)
        .length;
    final activeCount = enrolledCount - completedCount;
    final averageProgress = enrolledCount == 0
        ? 0
        : (enrollments
                      .map((e) => e.progressPercent)
                      .reduce((a, b) => a + b) /
                  enrolledCount)
              .round();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SmallStatCard(
                title: l10n.myLearningEnrolledLabel,
                value: '$enrolledCount',
                suffix: enrolledCount == 1
                    ? l10n.myLearningCourseSuffix
                    : l10n.myLearningCoursesSuffix,
                icon: Icons.menu_book_rounded,
                iconBackground: const Color(0xFFF5F9F7),
                progress: enrolledCount == 0
                    ? 0
                    : (enrolledCount / 5).clamp(0.0, 1.0),
                footerLeft: l10n.myLearningInProgressFooter,
                footerRight: l10n.myLearningActiveCount('$activeCount'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SmallStatCard(
                title: l10n.myLearningCertificatesLabel,
                value: '$completedCount',
                suffix: l10n.myLearningEarned,
                icon: Icons.verified_rounded,
                iconBackground: const Color(0xFFE7F5F0),
                showProgress: false,
                footerLeft: l10n.myLearningVerifiedCredential,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _AverageProgressCard(averageProgress: averageProgress),
      ],
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  const _SmallStatCard({
    required this.title,
    required this.value,
    required this.suffix,
    required this.icon,
    required this.iconBackground,
    this.progress = 0,
    this.footerLeft,
    this.footerRight,
    this.showProgress = true,
  });

  final String title;
  final String value;
  final String suffix;
  final IconData icon;
  final Color iconBackground;
  final double progress;
  final String? footerLeft;
  final String? footerRight;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.fromLTRB(15, 14, 15, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE1ECE8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .5,
                    color: const Color(0xFF82948F),
                  ),
                ),
              ),
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 14, color: const Color(0xFF075E4D)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF073F38),
                  ),
                ),
                TextSpan(
                  text: ' $suffix',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF405B55),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (showProgress) ...[
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 5,
                      backgroundColor: const Color(0xFFE8F0EE),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF08715E),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  footerRight ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF245D53),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
          if (footerLeft != null)
            Text(
              footerLeft!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 9,
                color: const Color(0xFF8A9A96),
              ),
            ),
        ],
      ),
    );
  }
}

class _AverageProgressCard extends StatelessWidget {
  const _AverageProgressCard({required this.averageProgress});

  final int averageProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE1ECE8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.l10n.myLearningAverageProgress.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .5,
                  color: const Color(0xFF82948F),
                ),
              ),
              const Spacer(),
              Text(
                '$averageProgress%',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF073F38),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: averageProgress / 100,
              minHeight: 8,
              backgroundColor: const Color(0xFFE8F0EE),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF08715E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
