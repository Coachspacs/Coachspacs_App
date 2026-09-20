import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

class CourseDetailsIncludes extends StatelessWidget {
  const CourseDetailsIncludes({
    super.key,
    required this.totalDurationMinutes,
    required this.totalLessons,
  });

  final int totalDurationMinutes;
  final int totalLessons;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hours = (totalDurationMinutes / 60).round();

    return Column(
      children: [
        _IncludeItem(
          icon: Icons.ondemand_video_outlined,
          text: l10n.courseDetailsTotalDuration('$hours'),
        ),
        _IncludeItem(
          icon: Icons.menu_book_outlined,
          text: l10n.courseDetailsLessonsCount('$totalLessons'),
        ),
        _IncludeItem(
          icon: Icons.description_outlined,
          text: l10n.courseDetailsDownloadableResources,
        ),
        _IncludeItem(
          icon: Icons.code_outlined,
          text: l10n.courseDetailsProjects,
        ),
        _IncludeItem(
          icon: Icons.access_time,
          text: l10n.courseDetailsLifetimeAccess,
        ),
        _IncludeItem(
          icon: Icons.workspace_premium_outlined,
          text: l10n.courseDetailsCertificate,
        ),
      ],
    );
  }
}

class _IncludeItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IncludeItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F4EF),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 15,
              color: const Color(0xFF075E4D),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF52635F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
