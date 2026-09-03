import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'instructor_course_management_shared.dart';

class InstructorCourseManagementOverview
    extends StatelessWidget {
  const InstructorCourseManagementOverview({
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
                label: 'Students',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: InstructorManagementStatCard(
                icon: Icons.trending_up_rounded,
                value: '78%',
                label: 'Completion',
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: InstructorManagementStatCard(
                icon: Icons.star_outline_rounded,
                value: '4.8',
                label: 'Rating',
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: InstructorManagementStatCard(
                icon: Icons.payments_outlined,
                value: '\$17.1K',
                label: 'Revenue',
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        InstructorManagementSectionCard(
          title: 'Course Overview',
          child: Column(
            children: [
              InstructorOverviewRow(
                icon: Icons.menu_book_outlined,
                title: 'Lessons',
                value: '42',
              ),

              InstructorOverviewRow(
                icon: Icons.schedule_outlined,
                title: 'Course Duration',
                value: '12h 45m',
              ),

              InstructorOverviewRow(
                icon: Icons.language_outlined,
                title: 'Language',
                value: 'English',
              ),

              InstructorOverviewRow(
                icon: Icons.attach_money_rounded,
                title: 'Course Price',
                value: '\$49.00',
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        InstructorManagementSectionCard(
          title: 'Course Progress',
          trailing: '78%',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const LinearProgressIndicator(
                  value: 0.78,
                  minHeight: 8,
                  backgroundColor: Color(0xFFE4ECE9),
                  valueColor: AlwaysStoppedAnimation(
                    Color(0xFF075E4D),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Most students are progressing well through the course.',
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