import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';

class CourseDetailsCurriculum extends StatelessWidget {
  const CourseDetailsCurriculum({
    super.key,
    required this.sections,
    this.enrollmentId,
    this.onLessonTap,
  });

  final List<CourseSectionDto> sections;

  /// Set when the student is enrolled; enables opening each lesson in the
  /// lesson player.
  final int? enrollmentId;

  /// Invoked with the lesson id of a tap. Only wired when [enrollmentId] is
  /// provided.
  final ValueChanged<int>? onLessonTap;

  @override
  Widget build(BuildContext context) {
    if (sections.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFDCE8E4)),
        ),
        child: Text(
          context.l10n.courseDetailsCurriculumEmpty,
          style: GoogleFonts.inter(
            fontSize: 12.5,
            color: const Color(0xFF71807C),
          ),
        ),
      );
    }

    final sorted = [...sections]..sort((a, b) => a.order.compareTo(b.order));

    return Column(
      children: [
        for (final section in sorted)
          _CurriculumSection(
            title: section.title,
            lessons: section.lessons,
            onLessonTap: onLessonTap,
          ),
      ],
    );
  }
}

class _CurriculumSection extends StatelessWidget {
  final String title;
  final List<CourseLessonDto> lessons;
  final ValueChanged<int>? onLessonTap;

  const _CurriculumSection({
    required this.title,
    required this.lessons,
    this.onLessonTap,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = [...lessons]..sort((a, b) => a.order.compareTo(b.order));

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDCE8E4)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 13),
        childrenPadding: const EdgeInsets.only(bottom: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF263C38),
          ),
        ),
        children: [
          for (final lesson in sorted)
            ListTile(
              dense: true,
              onTap: onLessonTap == null
                  ? null
                  : () => onLessonTap?.call(lesson.id),
              leading: const Icon(
                Icons.play_circle_outline,
                size: 17,
                color: Color(0xFF075E4D),
              ),
              title: Text(
                lesson.title,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF53645F),
                ),
              ),
              trailing: Text(
                lesson.isPreview
                    ? context.l10n.courseDetailsWatchPreview
                    : '${lesson.durationMinutes} min',
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
