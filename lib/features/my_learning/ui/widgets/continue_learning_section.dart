import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/features/profile/ui/widgets/dashboard/continue_learning_card.dart';

class ContinueLearningSection extends StatelessWidget {
  const ContinueLearningSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Continue Learning',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 10),

        ContinueLearningCard(
          courseTitle:
          'React 19 & Next.js App Router Masterclass',
          lesson:
          'Lesson 12: Advanced State Management',
          onPressed: () {
            // My Courses → Browse Courses
            Navigator.pushNamed(
              context,
              AppRoutes.browseCourses,
            );
          },
        ),
      ],
    );
  }
}