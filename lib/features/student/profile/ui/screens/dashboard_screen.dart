import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/helpers/protected_navigation.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/profile/logic/cubit/dashboard_cubit.dart';

import '../widgets/dashboard/continue_learning_card.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/dashboard_stat_card.dart';
import '../widgets/dashboard/dashboard_top_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (_) => getIt<DashboardCubit>()..load(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<DashboardCubit>().refresh(),
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DashboardTopBar(
                          onNotificationPressed: () =>
                              ProtectedNavigation.openNotifications(context),
                          onProfilePressed: () => Navigator.pushNamed(
                            context,
                            AppRoutes.profile,
                          ),
                        ),
                        const SizedBox(height: 24),
                        switch (state) {
                          DashboardInitial() ||
                          DashboardLoading() => const Padding(
                            padding: EdgeInsets.all(48),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          DashboardFailure failure => _FailureView(
                            message: localizedFailureMessage(
                              context,
                              failure.kind,
                              failure.message,
                            ),
                            onRetry: () =>
                                context.read<DashboardCubit>().load(),
                          ),
                          DashboardSuccess success => _SuccessView(
                            state: success,
                          ),
                        },
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.state});

  final DashboardSuccess state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final enrollments = state.enrollments;
    final completedCount = enrollments
        .where((e) => e.isCompleted)
        .length;
    final averageProgress = enrollments.isEmpty
        ? 0
        : (enrollments
                      .map((e) => e.progressPercent)
                      .reduce((a, b) => a + b) /
                  enrollments.length)
              .round();

    final continueEnrollment = _continueEnrollment(enrollments);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DashboardHeader(
          userName: state.userName.isNotEmpty
              ? state.userName
              : l10n.profileStudent,
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final cards = [
              DashboardStatCard(
                title: l10n.dashboardEnrolledLabel,
                value: l10n.dashboardCoursesCount('${state.totalEnrollments}'),
                backgroundColor: AppColors.white,
              ),
              DashboardStatCard(
                title: l10n.dashboardCertificatesLabel,
                value: l10n.dashboardEarnedCount('$completedCount'),
                backgroundColor: AppColors.successLight,
              ),
              DashboardStatCard(
                title: l10n.dashboardAverageProgressLabel,
                value: '$averageProgress%',
                backgroundColor: const Color(0xFFE8F8F7),
              ),
            ];

            if (constraints.maxWidth < 500) {
              return Column(
                children: [
                  for (final card in cards) ...[
                    card,
                    const SizedBox(height: 12),
                  ],
                ],
              );
            }

            return Row(
              children: [
                for (final card in cards) ...[
                  Expanded(child: card),
                  if (card != cards.last) const SizedBox(width: 12),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        if (continueEnrollment != null)
          ContinueLearningCard(
            courseTitle: continueEnrollment.course.title,
            progressPercent: continueEnrollment.progressPercent,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.courseDetails,
                arguments: continueEnrollment.course.id,
              );
            },
          )
        else
          _EmptyEnrollmentsCard(),
      ],
    );
  }

  EnrollmentDto? _continueEnrollment(List<EnrollmentDto> enrollments) {
    for (final enrollment in enrollments) {
      if (!enrollment.isCompleted) return enrollment;
    }
    return enrollments.isEmpty ? null : enrollments.first;
  }
}

class _EmptyEnrollmentsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF9F5),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD2EDE3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.dashboardNoEnrollments,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF173E37),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.catalog),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                context.l10n.myLearningBrowseCourses,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: Text(context.l10n.commonRetry),
          ),
        ],
      ),
    );
  }
}
