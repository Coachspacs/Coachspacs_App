import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/helpers/context_extensions.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/fade_slide_in.dart';
import '../../logic/cubit/my_path_cubit.dart';
import '../widgets/my_path/my_path_animated_roadmap.dart';
import '../widgets/my_path/my_path_benefits.dart';
import '../widgets/my_path/my_path_career_header.dart';
import '../widgets/my_path/my_path_milestones.dart';
import '../widgets/my_path/my_path_palette.dart';
import '../widgets/my_path/my_path_plan_summary.dart';
import '../widgets/my_path/my_path_primary_button.dart';
import '../widgets/my_path_roadmap/my_path_generating_view.dart';
import 'my_path_roadmap_screen.dart';

/// The My Path entry route (`/student-my-path`). The body morphs like the
/// web page does: wizard hub → "generating" placeholder → full roadmap once
/// a path exists for the signed-in student.
class MyPathScreen extends StatelessWidget {
  const MyPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<MyPathCubit>()..load(),
      child: const _MyPathView(),
    );
  }
}

class _MyPathView extends StatelessWidget {
  const _MyPathView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyPathColors.background,

      appBar: AppBar(
        backgroundColor: MyPathColors.background,
        foregroundColor: MyPathColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 23,
            color: MyPathColors.textPrimary,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        leadingWidth: 52,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          'My Path',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyPathColors.primary,
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: BlocBuilder<MyPathCubit, MyPathState>(
          builder: (context, state) {
            final roadmap = state.roadmap;
            // Mirrors the web route: once the student has a generated path
            // the page renders the interactive roadmap, otherwise it falls
            // back to the hub/wizard. While the path is still being fetched
            // (or generated) an animated placeholder avoids a flash.
            if (roadmap == null) {
              if (state.roadmapLoading) {
                final l10n = context.l10n;
                return MyPathGeneratingView(
                  title: l10n.myPathRoadmapGeneratingTitle,
                  subtitle: l10n.myPathRoadmapGeneratingSubtitle,
                );
              }
              return const _MyPathHubView();
            }
            if (roadmap.orderedSteps.isEmpty) {
              return const _MyPathHubView();
            }
            return const MyPathRoadmapView();
          },
        ),
      ),
    );
  }
}

/// The original hub (wizard launcher) view, shown when the student has no
/// generated path yet.
class _MyPathHubView extends StatelessWidget {
  const _MyPathHubView();

  static const List<String> _stepLabels = [
    'Goal',
    'Level',
    'Skill',
    'Schedule',
  ];

  static const List<String> _stepRoutes = [
    AppRoutes.studentMyPathGoal,
    AppRoutes.studentMyPathLevel,
    AppRoutes.studentMyPathSkill,
    AppRoutes.studentMyPathHours,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPathCubit, MyPathState>(
      builder: (context, state) {
        // The flag position follows the steps actually chosen — the server
        // may report the old plan as complete while the student is still
        // picking their new one.
        final completed = state.completedSteps >= 4;
        final currentStep = state.currentStep.clamp(0, 4);

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeSlideIn(
                index: 0,
                child: const MyPathCareerHeader(),
              ),
              const SizedBox(height: 12),
              FadeSlideIn(
                index: 1,
                child: MyPathAnimatedRoadmap(
                  labels: _stepLabels,
                  currentStep: currentStep,
                  height: 232,
                  trailingBadge: completed
                      ? 'Plan Complete'
                      : state.hasPlan
                          ? 'In Progress'
                          : 'Active Plan',
                ),
              ),
              const SizedBox(height: 10),
              FadeSlideIn(
                index: 2,
                child: state.hasPlan
                    ? MyPathPlanSummary(
                        goal: state.goal,
                        level: state.level,
                        skill: state.skill,
                        hours: state.hours,
                        completed: completed,
                      )
                    : const Text(
                        'A clear, guided step-by-step roadmap tailored to '
                        'your schedule, skill level, and ambitions.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.7,
                          fontWeight: FontWeight.w400,
                          color: MyPathColors.textMuted,
                        ),
                      ),
              ),
              const SizedBox(height: 22),
              FadeSlideIn(
                index: 3,
                child: MyPathMilestones(currentStep: state.currentStep),
              ),
              const SizedBox(height: 22),
              FadeSlideIn(
                index: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.bolt_rounded,
                          size: 19,
                          color: MyPathColors.primary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Why My Path?',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: MyPathColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const MyPathBenefits(),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              FadeSlideIn(
                index: 5,
                child: MyPathPrimaryButton(
                  label: _buttonLabel(state, completed),
                  subtitle:
                      completed ? 'You can retake the setup anytime' : null,
                  onPressed: () => _onPrimaryPressed(
                    context,
                    state,
                    completed,
                    currentStep,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _buttonLabel(MyPathState state, bool completed) {
    if (completed) return 'Customize My Path';
    if (state.hasPlan) {
      return 'Continue Setup — Step ${state.currentStep + 1} of 4';
    }
    return 'Start My Path';
  }

  void _onPrimaryPressed(
    BuildContext context,
    MyPathState state,
    bool completed,
    int currentStep,
  ) {
    if (completed) {
      context.read<MyPathCubit>().restart();
      Navigator.pushNamed(context, AppRoutes.studentMyPathGoal);
      return;
    }
    Navigator.pushNamed(context, _stepRoutes[currentStep]);
  }
}
