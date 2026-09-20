import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';
import 'package:coach_space/features/instructor/dashboard/logic/cubit/instructor_dashboard_cubit.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_earnings_card.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_overview_card.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_recent_courses.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_stats_grid.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_top_bar.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_welcome_card.dart';

class InstructorDashboardScreen extends StatefulWidget {
  const InstructorDashboardScreen({super.key});

  @override
  State<InstructorDashboardScreen> createState() =>
      _InstructorDashboardScreenState();
}

class _InstructorDashboardScreenState extends State<InstructorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            const InstructorTopBar(),
            Expanded(
              child: BlocProvider(
                create: (_) {
                  final cubit = getIt<InstructorDashboardCubit>();
                  cubit.load();
                  return cubit;
                },
                child: BlocBuilder<InstructorDashboardCubit,
                    InstructorDashboardState>(
                  builder: (context, state) {
                    return switch (state) {
                      InstructorDashboardInitial() ||
                      InstructorDashboardLoading() => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF075E4D),
                        ),
                      ),
                      InstructorDashboardFailure() => _DashboardFailureView(
                        message: localizedFailureMessage(
                          context,
                          state.kind,
                          state.message,
                        ),
                        onRetry: () =>
                            context.read<InstructorDashboardCubit>().load(),
                      ),
                      InstructorDashboardSuccess() => SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
                        child: _DashboardContent(
                          totalCourses: state.totalCourses,
                          underReview: state.underReview,
                          drafts: state.drafts,
                          totalStudents: state.totalStudents,
                          revenue: state.dashboard.totalRevenue,
                          totalLessons: state.dashboard.totalLessons,
                          totalDurationMinutes:
                              state.dashboard.totalDurationMinutes,
                          recentCourses: state.recentCourses,
                        ),
                      ),
                    };
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 0,
        navType: NavType.instructor,
        onItemSelected: (index) => _handleNavigation(context, index),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorCourses,
          (route) => false,
        );
        break;
      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorStudents,
          (route) => false,
        );
        break;
      case 3:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorProfile,
          (route) => false,
        );
        break;
    }
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.totalCourses,
    required this.underReview,
    required this.drafts,
    required this.totalStudents,
    required this.revenue,
    required this.totalLessons,
    required this.totalDurationMinutes,
    required this.recentCourses,
  });

  final int totalCourses;
  final int underReview;
  final int drafts;
  final int totalStudents;
  final String? revenue;
  final int? totalLessons;
  final int? totalDurationMinutes;
  final List<InstructorCourseDto> recentCourses;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InstructorWelcomeCard(),
        const SizedBox(height: 16),
        InstructorStatsGrid(
          totalCourses: totalCourses,
          underReview: underReview,
          drafts: drafts,
          totalStudents: totalStudents,
        ),
        const SizedBox(height: 14),
        InstructorEarningsCard(amount: revenue),
        const SizedBox(height: 22),
        InstructorOverviewCard(
          totalLessons: totalLessons,
          totalDurationMinutes: totalDurationMinutes,
        ),
        const SizedBox(height: 24),
        InstructorRecentCourses(courses: recentCourses),
      ],
    );
  }
}

class _DashboardFailureView extends StatelessWidget {
  const _DashboardFailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 46,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: const Color(0xFF71827E),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 17),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}