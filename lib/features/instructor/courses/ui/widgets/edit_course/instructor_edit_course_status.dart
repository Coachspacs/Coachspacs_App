import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/features/instructor/courses/ui/screens/instructor_courses_screen.dart';

class InstructorEditCourseStatus extends StatelessWidget {
  const InstructorEditCourseStatus({
    super.key,
    required this.status,
    this.rejectionReason,
  });

  final CourseStatus status;
  final String? rejectionReason;

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0EAE7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: config.iconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  config.icon,
                  size: 19,
                  color: config.iconColor,
                ),
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Status',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF073F38),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Current publication status.',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: const Color(0xFF84928E),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: config.badgeBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status.label,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: config.badgeForeground,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: config.messageBackground,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  config.icon,
                  size: 20,
                  color: config.iconColor,
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        config.message,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF344540),
                        ),
                      ),
                      if (status == CourseStatus.rejected &&
                          rejectionReason != null &&
                          rejectionReason!.trim().isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          rejectionReason!.trim(),
                          style: GoogleFonts.inter(
                            fontSize: 9.5,
                            height: 1.35,
                            color: const Color(0xFFB65B48),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusConfig {
  const _StatusConfig({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.badgeBackground,
    required this.badgeForeground,
    required this.messageBackground,
    required this.message,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final Color badgeBackground;
  final Color badgeForeground;
  final Color messageBackground;
  final String message;
}

_StatusConfig _statusConfig(CourseStatus status) {
  switch (status) {
    case CourseStatus.published:
      return const _StatusConfig(
        icon: Icons.check_circle_rounded,
        iconColor: Color(0xFF075E4D),
        iconBackground: Color(0xFFE8F4F0),
        badgeBackground: Color(0xFFDDF3EB),
        badgeForeground: Color(0xFF075E4D),
        messageBackground: Color(0xFFF0F8F5),
        message: 'This course is currently published.',
      );

    case CourseStatus.pendingReview:
      return const _StatusConfig(
        icon: Icons.pending_outlined,
        iconColor: Color(0xFFA16F00),
        iconBackground: Color(0xFFFFF6E3),
        badgeBackground: Color(0xFFFFF0CF),
        badgeForeground: Color(0xFF9A6A00),
        messageBackground: Color(0xFFFFF7E5),
        message: 'This course is currently under review.',
      );

    case CourseStatus.draft:
      return const _StatusConfig(
        icon: Icons.description_outlined,
        iconColor: Color(0xFF687772),
        iconBackground: Color(0xFFF0F3F2),
        badgeBackground: Color(0xFFEDEFF0),
        badgeForeground: Color(0xFF687772),
        messageBackground: Color(0xFFF5F7F7),
        message: 'This course is a draft. Submit it for review when ready.',
      );

    case CourseStatus.rejected:
      return const _StatusConfig(
        icon: Icons.error_outline_rounded,
        iconColor: Color(0xFFC95548),
        iconBackground: Color(0xFFFFECE8),
        badgeBackground: Color(0xFFFFE5E2),
        badgeForeground: Color(0xFFC95548),
        messageBackground: Color(0xFFFFF4F1),
        message: 'This course was rejected. Review the feedback and resubmit.',
      );

    case CourseStatus.archived:
      return const _StatusConfig(
        icon: Icons.archive_outlined,
        iconColor: Color(0xFF4F6170),
        iconBackground: Color(0xFFE9EEF3),
        badgeBackground: Color(0xFFE4EAF0),
        badgeForeground: Color(0xFF4F6170),
        messageBackground: Color(0xFFF3F6F8),
        message: 'This course is archived and hidden from new students.',
      );
  }
}
