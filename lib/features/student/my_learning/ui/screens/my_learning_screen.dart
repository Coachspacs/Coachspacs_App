import 'package:flutter/material.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';

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
  List<EnrollmentDto> _enrollments = const [];

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
    _loadEnrollments();
  }

  Future<void> _loadEnrollments() async {
    try {
      final page = await getIt<EnrollmentRepository>().getEnrollments(
        pageSize: 50,
      );
      if (mounted) setState(() => _enrollments = page.results);
    } catch (_) {
      // The dedicated browse screen presents retry feedback; this overview
      // remains usable when its optional summary request fails.
    }
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
                  children: [
                    const MyLearningHeader(),
                    const SizedBox(height: 18),
                    const MyLearningStats(),
                    const SizedBox(height: 22),
                    ContinueLearningSection(enrollments: _enrollments),
                    const SizedBox(height: 24),
                    MyCoursesSection(enrollments: _enrollments),
                    const SizedBox(height: 24),
                    const MyCertificatesSection(),
                    const SizedBox(height: 24),
                    const RecentActivitySection(),
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
