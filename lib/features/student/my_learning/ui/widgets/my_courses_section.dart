import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/app_routes.dart';

class MyCoursesSection extends StatelessWidget {
  const MyCoursesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =====================================================
        // MY COURSES HEADER
        // =====================================================
        Row(
          children: [
            // Clicking My Courses opens all enrolled courses.
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.browseCourses,
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: Text(
                  'My Courses',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // View All opens all enrolled courses.
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.browseCourses,
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
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // =====================================================
        // COURSE 1
        // =====================================================
        _LearningCourseCard(
          title:
          'React 19 & Next.js App Router',
          progress: 0.65,
          completedLessons: '12 / 18 lessons',
          onContinue: () {
            Navigator.pushNamed(
              context,
              AppRoutes.courseDetails,
              arguments: {
                'title':
                'React 19 & Next.js App Router',
                'instructor': 'Mohamed Katanani',
                'price': '\$89.00',
                'rating': '4.9',
                'students': '2.4k',
                'image': '',
              },
            );
          },
        ),

        const SizedBox(height: 10),

        // =====================================================
        // COURSE 2
        // =====================================================
        _LearningCourseCard(
          title:
          'UI/UX Design Systems for Enterprise',
          progress: 0.40,
          completedLessons: '6 / 15 lessons',
          onContinue: () {
            Navigator.pushNamed(
              context,
              AppRoutes.courseDetails,
              arguments: {
                'title':
                'UI/UX Design Systems for Enterprise',
                'instructor':
                'Dr. Tareq Al-Mansoor',
                'price': '\$69.00',
                'rating': '4.8',
                'students': '1.8k',
                'image': '',
              },
            );
          },
        ),
      ],
    );
  }
}

class _LearningCourseCard extends StatelessWidget {
  const _LearningCourseCard({
    required this.title,
    required this.progress,
    required this.completedLessons,
    required this.onContinue,
  });

  final String title;
  final double progress;
  final String completedLessons;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                  BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor:
                    const Color(0xFFE5EFEC),
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(
                      Color(0xFF075E4D),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Text(
                '${(progress * 100).round()}%',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Text(
                completedLessons,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF71807C),
                ),
              ),

              const Spacer(),

              TextButton(
                onPressed: onContinue,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Continue →',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF075E4D),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}