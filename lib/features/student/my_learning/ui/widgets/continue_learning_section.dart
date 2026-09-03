import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

import '../../../profile/ui/widgets/dashboard/continue_learning_card.dart';

class ContinueLearningSection extends StatelessWidget {
  const ContinueLearningSection({super.key, required this.enrollments});

  final List<EnrollmentDto> enrollments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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

        if (enrollments.isEmpty)
          const Text('No courses in progress yet.')
        else
          ContinueLearningCard(
            courseTitle: enrollments.first.course.title,
            lesson: enrollments.first.isCompleted
                ? 'Course completed'
                : 'Continue where you left off',
            onPressed: () {
              // My Courses → Browse Courses
              Navigator.pushNamed(context, AppRoutes.browseCourses);
            },
          ),
      ],
    );
  }
}
