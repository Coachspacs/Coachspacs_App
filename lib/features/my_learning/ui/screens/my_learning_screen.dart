import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';

import 'package:coach_space/features/my_learning/ui/widgets/my_learning_header.dart';
import 'package:coach_space/features/my_learning/ui/widgets/my_learning_stats.dart';
import 'package:coach_space/features/my_learning/ui/widgets/continue_learning_section.dart';
import 'package:coach_space/features/my_learning/ui/widgets/my_courses_section.dart';
import 'package:coach_space/features/my_learning/ui/widgets/my_certificates_section.dart';
import 'package:coach_space/features/my_learning/ui/widgets/recent_activity_section.dart';

class MyLearningScreen extends StatelessWidget {
  const MyLearningScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: const [
              // Header
              MyLearningHeader(),

              SizedBox(height: 20),

              // Statistics
              MyLearningStats(),

              SizedBox(height: 24),

              // Continue Learning
              ContinueLearningSection(),

              SizedBox(height: 26),

              // My Courses
              MyCoursesSection(),

              SizedBox(height: 26),

              // Certificates
              MyCertificatesSection(),

              SizedBox(height: 26),

              // Recent Activity
              RecentActivitySection(),
            ],
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: const BottomNavBarWidget(
        currentIndex: 2,
      ),
    );
  }
}