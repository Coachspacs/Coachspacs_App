import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

/// Real "recent activity" derived from the enrollment list: the three most
/// recently enrolled courses with their current status.
class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({
    super.key,
    required this.enrollments,
  });

  final List<EnrollmentDto> enrollments;

  @override
  Widget build(BuildContext context) {
    if (enrollments.isEmpty) return const SizedBox.shrink();

    final sorted = [...enrollments]
      ..sort((a, b) => b.enrolledAt.compareTo(a.enrolledAt));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.myLearningRecentActivity,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),
        const SizedBox(height: 10),
        for (final enrollment in sorted.take(3))
          _ActivityItem(enrollment: enrollment),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({required this.enrollment});

  final EnrollmentDto enrollment;

  @override
  Widget build(BuildContext context) {
    final completed = enrollment.isCompleted;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE0ECE8)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE5F5F0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              completed
                  ? Icons.check_circle_outline_rounded
                  : Icons.play_circle_outline_rounded,
              size: 19,
              color: const Color(0xFF08715E),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  enrollment.course.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF173E37),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  completed
                      ? context.l10n.myLearningCourseCompleted
                      : '${enrollment.progressPercent}% '
                            '${context.l10n.myLearningInProgressFooter.toLowerCase()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: const Color(0xFF91A09C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            DateFormat.yMMMd(
              Localizations.localeOf(context).toString(),
            ).format(enrollment.enrolledAt.toLocal()),
            style: GoogleFonts.inter(
              fontSize: 8.5,
              color: const Color(0xFF8A9A96),
            ),
          ),
        ],
      ),
    );
  }
}
