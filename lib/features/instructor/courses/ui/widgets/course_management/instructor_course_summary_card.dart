import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/instructor/courses/ui/screens/instructor_courses_screen.dart';

class InstructorCourseSummaryCard extends StatelessWidget {
  const InstructorCourseSummaryCard({
    super.key,
    required this.course,
  });

  final InstructorCourse course;

  static ({Color foreground, Color background}) _statusStyle(
    CourseStatus status,
  ) {
    switch (status) {
      case CourseStatus.published:
        return (
          foreground: const Color(0xFF218066),
          background: const Color(0xFFE2F5EF),
        );
      case CourseStatus.pendingReview:
        return (
          foreground: const Color(0xFF9A6A00),
          background: const Color(0xFFFFF0CF),
        );
      case CourseStatus.draft:
        return (
          foreground: const Color(0xFF687772),
          background: const Color(0xFFEDEFF0),
        );
      case CourseStatus.rejected:
        return (
          foreground: const Color(0xFFC95548),
          background: const Color(0xFFFFE5E2),
        );
      case CourseStatus.archived:
        return (
          foreground: const Color(0xFF4F6170),
          background: const Color(0xFFE4EAF0),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _statusStyle(course.status);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 86,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2EF),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              course.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF075E4D),
                  size: 30,
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusStyle.background,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    course.status.label.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      color: statusStyle.foreground,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  course.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF173D37),
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      Icons.people_outline_rounded,
                      size: 13,
                      color: Color(0xFF82918D),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      course.students,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: const Color(0xFF71807C),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.attach_money_rounded,
                      size: 13,
                      color: Color(0xFF82918D),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      course.displayPrice,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: course.isFree
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: course.isFree
                            ? const Color(0xFF075E4D)
                            : const Color(0xFF71807C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.instructorCourseEdit,
                arguments: course,
              );
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            icon: const Icon(
              Icons.edit_outlined,
              size: 17,
              color: Color(0xFF667570),
            ),
          ),
        ],
      ),
    );
  }
}
