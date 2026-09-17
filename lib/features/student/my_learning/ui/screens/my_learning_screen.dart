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

      if (mounted) {
        setState(() {
          _enrollments = page.results;
        });
      }
    } catch (_) {
      // Keep the screen usable if the optional request fails.
    }
  }

  @override
  Widget build(BuildContext context) {
    if (GuestSession.isGuest) {
      return const Scaffold(
        backgroundColor: AppColors.bgDefault,
        body: SizedBox.shrink(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            // Existing project header — keep as is.
            const MyLearningTopBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  14,
                  16,
                  28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyLearningHeader(),

                    const SizedBox(height: 16),

                    MyLearningStats(
                      enrollments: _enrollments,
                    ),

                    const SizedBox(height: 18),

                    ContinueLearningSection(
                      enrollments: _enrollments,
                    ),

                    const SizedBox(height: 22),

                    MyCoursesSection(
                      enrollments: _enrollments,
                    ),

                    const SizedBox(height: 22),

                    const MyCertificatesSection(),

                    const SizedBox(height: 22),

                    const RecentActivitySection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBarWidget(
        navType: NavType.student,
        currentIndex: 2,
      ),
    );
  }
}