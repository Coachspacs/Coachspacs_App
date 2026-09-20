import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';

class InstructorRecentCourses extends StatelessWidget {
  const InstructorRecentCourses({
    super.key,
    required this.courses,
  });

  final List<InstructorCourseDto> courses;

  @override
  Widget build(BuildContext context) {
    final items = courses.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =====================================================
        // SECTION HEADER
        // =====================================================

        Row(
          children: [
            Text(
              'Recently Edited',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),

            const Spacer(),

            // =================================================
            // VIEW ALL
            // =================================================

            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.instructorCourses,
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        // =====================================================
        // COURSES CONTAINER
        // =====================================================

        if (items.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE1EAE7),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.menu_book_outlined,
                  size: 26,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 8),
                Text(
                  'No courses yet. Create your first course to get started.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    color: const Color(0xFF899590),
                  ),
                ),
              ],
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFE1EAE7),
              ),
            ),
            child: Column(
              children: [
                for (int index = 0;
                index < items.length;
                index++)
                  _RecentCourseItem(
                    course: items[index],
                    showDivider:
                    index != items.length - 1,
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

// =============================================================
// COURSE STATUS COLORS
// =============================================================

class _CourseStatusStyle {
  const _CourseStatusStyle(this.color, this.background);

  final Color color;
  final Color background;
}

_CourseStatusStyle _statusStyle(String status) {
  switch (status.toUpperCase()) {
    case 'PUBLISHED':
      return const _CourseStatusStyle(
        Color(0xFF2C8A70),
        Color(0xFFE5F5F0),
      );
    case 'PENDING':
    case 'PENDING_REVIEW':
    case 'UNDER_REVIEW':
      return const _CourseStatusStyle(
        Color(0xFFB27A16),
        Color(0xFFFFF4D9),
      );
    case 'REJECTED':
      return const _CourseStatusStyle(
        Color(0xFFC0392B),
        Color(0xFFFDECEC),
      );
    case 'DRAFT':
    default:
      return const _CourseStatusStyle(
        Color(0xFF687772),
        Color(0xFFF0F3F2),
      );
  }
}

// =============================================================
// COURSE ITEM
// =============================================================

class _RecentCourseItem extends StatelessWidget {
  const _RecentCourseItem({
    required this.course,
    required this.showDivider,
  });

  final InstructorCourseDto course;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final style = _statusStyle(course.status);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
          bottom: BorderSide(
            color: Color(0xFFE9EFED),
          ),
        )
            : null,
      ),
      child: Row(
        children: [
          // =================================================
          // COURSE ICON
          // =================================================

          Container(
            width: 52,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2EF),
              borderRadius: BorderRadius.circular(9),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.play_lesson_outlined,
              size: 22,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 11),

          // =================================================
          // COURSE INFO
          // =================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // STATUS
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: style.background,
                    borderRadius:
                    BorderRadius.circular(5),
                  ),
                  child: Text(
                    course.status,
                    style: GoogleFonts.inter(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w800,
                      color: style.color,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // TITLE
                Text(
                  course.displayTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF263C38),
                  ),
                ),

                const SizedBox(height: 4),

                // TIME
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      size: 11,
                      color: Color(0xFF8A9692),
                    ),

                    const SizedBox(width: 3),

                    Text(
                      _relativeTime(course.updatedAt),
                      style: GoogleFonts.inter(
                        fontSize: 9.5,
                        color: const Color(0xFF899590),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // =================================================
          // MORE
          // =================================================

          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 28,
              minHeight: 28,
            ),
            icon: const Icon(
              Icons.more_vert,
              size: 18,
              color: Color(0xFF667570),
            ),
          ),
        ],
      ),
    );
  }

  static String _relativeTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'Recently';
    final parsed = DateTime.tryParse(dateTime);
    if (parsed == null) return 'Recently';
    final difference = DateTime.now().difference(parsed);
    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    }
    if (difference.inHours < 24) return '${difference.inHours} hr ago';
    if (difference.inDays < 30) return '${difference.inDays} days ago';
    return '${parsed.year}-${parsed.month}-${parsed.day}';
  }
}