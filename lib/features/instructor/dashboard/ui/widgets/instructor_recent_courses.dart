import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorRecentCourses
    extends StatelessWidget {
  const InstructorRecentCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const courses = [
      _CourseData(
        title: 'Advanced Flutter Architecture',
        status: 'PUBLISHED',
        statusColor: Color(0xFF2C8A70),
        statusBackground: Color(0xFFE5F5F0),
        time: '2 hrs ago',
        icon: Icons.flutter_dash,
      ),
      _CourseData(
        title: 'UX/UI Masterclass 2024',
        status: 'DRAFT',
        statusColor: Color(0xFF687772),
        statusBackground: Color(0xFFF0F3F2),
        time: '1 day ago',
        icon: Icons.design_services_outlined,
      ),
      _CourseData(
        title: 'Intro to Machine Learning',
        status: 'PENDING',
        statusColor: Color(0xFFB27A16),
        statusBackground: Color(0xFFFFF4D9),
        time: '3 days ago',
        icon: Icons.memory_outlined,
      ),
    ];

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Last Edited',
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),

            const Spacer(),

            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

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
              index < courses.length;
              index++)
                _RecentCourseItem(
                  course: courses[index],
                  showDivider:
                  index != courses.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================
// COURSE DATA
// =============================================================

class _CourseData {
  const _CourseData({
    required this.title,
    required this.status,
    required this.statusColor,
    required this.statusBackground,
    required this.time,
    required this.icon,
  });

  final String title;
  final String status;
  final Color statusColor;
  final Color statusBackground;
  final String time;
  final IconData icon;
}

// =============================================================
// COURSE ITEM
// =============================================================

class _RecentCourseItem
    extends StatelessWidget {
  const _RecentCourseItem({
    required this.course,
    required this.showDivider,
  });

  final _CourseData course;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
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
          Container(
            width: 52,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2EF),
              borderRadius:
              BorderRadius.circular(9),
            ),
            child: Icon(
              course.icon,
              size: 22,
              color: const Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: course.statusBackground,
                    borderRadius:
                    BorderRadius.circular(5),
                  ),
                  child: Text(
                    course.status,
                    style: GoogleFonts.inter(
                      fontSize: 6.5,
                      fontWeight:
                      FontWeight.w800,
                      color: course.statusColor,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  course.title,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color:
                    const Color(0xFF263C38),
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      size: 11,
                      color: Color(0xFF8A9692),
                    ),

                    const SizedBox(width: 3),

                    Text(
                      course.time,
                      style: GoogleFonts.inter(
                        fontSize: 7.5,
                        color:
                        const Color(0xFF899590),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

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
}