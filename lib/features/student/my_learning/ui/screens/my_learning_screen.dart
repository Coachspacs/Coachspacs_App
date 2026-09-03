import 'package:flutter/material.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';

import '../widgets/continue_learning_section.dart';
import '../widgets/my_certificates_section.dart';
import '../widgets/my_courses_section.dart';
import '../widgets/my_learning_header.dart';
import '../widgets/my_learning_stats.dart';
import '../widgets/my_learning_top_bar.dart';
import '../widgets/recent_activity_section.dart';

class MyLearningScreen extends StatefulWidget {
  const MyLearningScreen({super.key});

  @override
  State<MyLearningScreen> createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen> {
  @override
  void initState() {
    super.initState();

    // =====================================================
    // GUEST PROTECTION
    // =====================================================

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (GuestSession.isGuest) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // =====================================================
    // GUEST
    // =====================================================

    if (GuestSession.isGuest) {
      return const Scaffold(
        backgroundColor: AppColors.bgDefault,
        body: SizedBox.shrink(),
      );
    }

    // =====================================================
    // LOGGED-IN STUDENT
    // =====================================================

    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // TOP BAR
            // =================================================
            const MyLearningTopBar(),

            // =================================================
            // CONTENT
            // =================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    MyLearningHeader(),

                    SizedBox(height: 18),

                    MyLearningStats(),

                    SizedBox(height: 22),

                    ContinueLearningSection(),

                    SizedBox(height: 24),

                    MyCoursesSection(),

                    SizedBox(height: 24),

                    MyCertificatesSection(),

                    SizedBox(height: 24),

                    RecentActivitySection(),
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
      bottomNavigationBar: const BottomNavBarWidget(
        navType: NavType.student,

        currentIndex: 2,
      ),
    );
  }
}
