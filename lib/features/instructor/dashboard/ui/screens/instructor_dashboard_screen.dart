import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_earnings_card.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_overview_card.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_recent_courses.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_stats_grid.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_top_bar.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_welcome_card.dart';

class InstructorDashboardScreen extends StatelessWidget {
  const InstructorDashboardScreen({
    super.key,
  });

  // =====================================================
  // BOTTOM NAVIGATION
  // =====================================================

  void _handleNavigation(
      BuildContext context,
      int index,
      ) {
    switch (index) {
    // =================================================
    // DASHBOARD
    // =================================================

      case 0:
      // Already on Dashboard.
        break;

    // =================================================
    // COURSES
    // =================================================

      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorCourses,
              (route) => false,
        );
        break;

    // =================================================
    // STUDENTS
    // =================================================

      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorStudents,
              (route) => false,
        );
        break;

    // =================================================
    // PROFILE
    // =================================================

      case 3:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorProfile,
              (route) => false,
        );
        break;
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      // =====================================================
      // BODY
      // =====================================================

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // TOP BAR
            // =================================================

            const InstructorTopBar(),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    // =================================================
                    // WELCOME
                    // =================================================

                    InstructorWelcomeCard(),

                    SizedBox(height: 16),

                    // =================================================
                    // MAIN STATISTICS
                    // =================================================

                    InstructorStatsGrid(),

                    SizedBox(height: 14),

                    // =================================================
                    // EARNINGS
                    // =================================================

                    InstructorEarningsCard(),

                    SizedBox(height: 22),

                    // =================================================
                    // INSTRUCTOR OVERVIEW
                    // =================================================

                    InstructorOverviewCard(),

                    SizedBox(height: 24),

                    // =================================================
                    // RECENT COURSES
                    // =================================================

                    InstructorRecentCourses(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================

      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0,
        navType: NavType.instructor,
        onItemSelected: (index) {
          _handleNavigation(
            context,
            index,
          );
        },
      ),
    );
  }
}