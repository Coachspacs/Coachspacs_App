import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'instructor_course_management_shared.dart';

class InstructorCourseManagementAnalytics
    extends StatelessWidget {
  const InstructorCourseManagementAnalytics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InstructorManagementStatCard(
                icon: Icons.people_outline_rounded,
                value: '350',
                label: 'Total Students',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: InstructorManagementStatCard(
                icon: Icons.play_circle_outline_rounded,
                value: '2,450',
                label: 'Enrollments',
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: InstructorManagementStatCard(
                icon: Icons.trending_up_rounded,
                value: '78%',
                label: 'Completion Rate',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: InstructorManagementStatCard(
                icon: Icons.star_outline_rounded,
                value: '4.8',
                label: 'Average Rating',
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        InstructorManagementSectionCard(
          title: 'Performance',
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'Course completion',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF263C38),
                ),
              ),

              const SizedBox(height: 12),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const LinearProgressIndicator(
                  value: 0.78,
                  minHeight: 9,
                  backgroundColor: Color(0xFFE4ECE9),
                  valueColor: AlwaysStoppedAnimation(
                    Color(0xFF075E4D),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                '78% of enrolled students completed the course.',
                style: GoogleFonts.inter(
                  fontSize: 8.5,
                  color: const Color(0xFF7B8985),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}