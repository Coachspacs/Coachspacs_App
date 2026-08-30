import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_bottom_nav_bar.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_earnings_card.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_overview_card.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_quick_actions.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_recent_courses.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_stats_grid.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_top_bar.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_welcome_card.dart';

class InstructorDashboardScreen extends StatelessWidget {
  const InstructorDashboardScreen({
    super.key,
  });

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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: const [
                    // Welcome
                    InstructorWelcomeCard(),

                    SizedBox(height: 16),

                    // Main statistics
                    InstructorStatsGrid(),

                    SizedBox(height: 14),

                    // Earnings
                    InstructorEarningsCard(),

                    SizedBox(height: 22),

                    // Instructor overview
                    InstructorOverviewCard(),

                    SizedBox(height: 22),

                    // Quick actions
                    InstructorQuickActions(),

                    SizedBox(height: 24),

                    // Recent courses
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

      bottomNavigationBar:
      const InstructorBottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}