import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/student/my_learning/logic/cubit/my_learning_cubit.dart';

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
  late final MyLearningCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<MyLearningCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (GuestSession.isGuest) {
        Navigator.pop(context);
      }
    });

    if (!GuestSession.isGuest) {
      _cubit.load();
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (GuestSession.isGuest) {
      return const Scaffold(
        backgroundColor: AppColors.bgDefault,
        body: SizedBox.shrink(),
      );
    }

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.bgDefault,
        body: SafeArea(
          child: Column(
            children: [
              const MyLearningTopBar(),
              Expanded(
                child: BlocBuilder<MyLearningCubit, MyLearningState>(
                  builder: (context, state) {
                    return RefreshIndicator(
                      onRefresh: _cubit.refresh,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyLearningHeader(),
                            const SizedBox(height: 16),
                            _buildBody(state),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBarWidget(
          navType: NavType.student,
          currentIndex: 2,
        ),
      ),
    );
  }

  Widget _buildBody(MyLearningState state) {
    switch (state) {
      case MyLearningInitial():
      case MyLearningLoading():
        return const Padding(
          padding: EdgeInsets.all(48),
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        );

      case MyLearningFailure():
        return _FailureView(
          message: localizedFailureMessage(context, state.kind, state.message),
          onRetry: _cubit.load,
        );

      case MyLearningEmpty():
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCoursesSection(enrollments: const []),
            const SizedBox(height: 22),
            MyCertificatesSection(certificates: state.certificates),
          ],
        );

      case MyLearningSuccess():
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyLearningStats(enrollments: state.enrollments),
            const SizedBox(height: 18),
            ContinueLearningSection(enrollments: state.enrollments),
            const SizedBox(height: 22),
            MyCoursesSection(enrollments: state.enrollments),
            const SizedBox(height: 22),
            MyCertificatesSection(certificates: state.certificates),
            const SizedBox(height: 22),
            RecentActivitySection(enrollments: state.enrollments),
          ],
        );
    }
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(context.l10n.commonRetry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
