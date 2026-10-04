import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/fade_slide_in.dart';
import '../../data/models/roadmap_dtos.dart';
import '../../logic/cubit/my_path_cubit.dart';
import '../widgets/my_path/my_path_palette.dart';
import '../widgets/my_path_roadmap/my_path_roadmap_canvas.dart';
import '../widgets/my_path_roadmap/my_path_roadmap_header.dart';
import '../widgets/my_path_roadmap/my_path_reorder_sheet.dart';
import '../widgets/my_path_roadmap/my_path_stage_card.dart';

/// The My Path roadmap view — a clone of the web `/student/my-path` screen:
/// dark hero header + vertical milestone rail with expandable stage cards,
/// done/skip/reorder actions wired to the AI-roadmap API.
class MyPathRoadmapView extends StatefulWidget {
  const MyPathRoadmapView({super.key});

  @override
  State<MyPathRoadmapView> createState() => _MyPathRoadmapViewState();
}

class _MyPathRoadmapViewState extends State<MyPathRoadmapView> {
  /// Web behaviour: one milestone card expanded at a time, defaulting to the
  /// step the student should currently be working on. Track whether the
  /// default was applied so explicit collapses survive rebuilds.
  String? _expandedId;
  bool _expandedInitialized = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyPathCubit, MyPathState>(
      listener: (context, state) {
        if (_expandedInitialized) return;
        final roadmap = state.roadmap;
        if (roadmap != null && roadmap.orderedSteps.isNotEmpty) {
          _expandedId =
              '${roadmap.orderedSteps[roadmap.currentActiveIndex].id}';
          _expandedInitialized = true;
        }
      },
      builder: (context, state) {
        final l10n = context.l10n;
        final roadmap = state.roadmap;
        if (roadmap == null) return const SizedBox.shrink();
        final ordered = roadmap.orderedSteps;
        if (ordered.isEmpty) return const _EmptyRoadmap();
        final activeIndex = roadmap.currentActiveIndex;
        final weeklyHours = double.tryParse(roadmap.weeklyHours ?? '6') ?? 6;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FadeSlideIn(
                index: 0,
                child: MyPathRoadmapHeader(
                  completed: roadmap.completedSteps,
                  total: roadmap.totalSteps,
                  title: (roadmap.goalText?.trim().isNotEmpty ?? false)
                      ? roadmap.goalText!
                      : (roadmap.categoryName?.trim().isNotEmpty ?? false)
                          ? roadmap.categoryName!
                          : l10n.myPathRoadmapDefaultTitle,
                  headerBadge: l10n.myPathRoadmapHeaderBadge,
                  milestonesBadge: l10n.myPathRoadmapMilestonesBadge(
                    '${roadmap.totalSteps}',
                  ),
                  progressLabel: l10n.myPathRoadmapProgressLabel(
                    '${roadmap.completedSteps}',
                    '${roadmap.totalSteps}',
                  ),
                  reorderLabel: l10n.myPathRoadmapReorderSteps,
                  regenerateLabel: l10n.myPathRoadmapRegeneratePath,
                  onReorder: () => MyPathReorderSheet.show(
                    context,
                    labels: (key) => switch (key) {
                      'title' => l10n.myPathRoadmapReorderTitle,
                      'subtitle' => l10n.myPathRoadmapReorderSubtitle,
                      'completed' => l10n.myPathRoadmapReorderCompleted,
                      'skipped' => l10n.myPathRoadmapReorderSkipped,
                      'note' => l10n.myPathRoadmapReorderNote,
                      'save' => l10n.myPathRoadmapReorderSaveOrder,
                      _ => key,
                    },
                  ),
                  onRegenerate: () {
                    context.read<MyPathCubit>().restart();
                    // Keep this hub below in the stack so finishing the
                    // wizard surfaces the freshly generated path.
                    Navigator.pushNamed(context, AppRoutes.studentMyPathGoal);
                  },
                ),
              ),
              const SizedBox(height: 20),
              FadeSlideIn(
                index: 1,
                child: MyPathRoadmapCanvas(
                  steps: ordered,
                  activeIndex: activeIndex,
                  expandedId: _expandedId,
                  activeBadgeLabel: l10n.myPathRoadmapActiveBadgeLabel,
                  levelBadgeLabel: l10n.myPathRoadmapLevelBadgeLabel,
                  youAreHereLabel: l10n.myPathRoadmapYouAreHere,
                  startLineLabel: l10n.myPathRoadmapStartLine,
                  goalPillLabel: l10n.myPathRoadmapGoalPill,
                  onRailTap: _toggleExpand(ordered, activeIndex),
                  cardBuilder: (index) => _buildCard(
                    context,
                    state,
                    ordered,
                    index,
                    activeIndex,
                    weeklyHours,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Tapping a rail badge expands that milestone (collapses if already
  /// expanded), mirroring the web rail buttons.
  ValueChanged<int> _toggleExpand(
    List<RoadmapStepDto> ordered,
    int activeIndex,
  ) {
    return (index) {
      setState(() {
        if (index >= 0 && index < ordered.length) {
          final id = '${ordered[index].id}';
          _expandedId = _expandedId == id ? null : id;
        }
      });
    };
  }

  Widget _buildCard(
    BuildContext context,
    MyPathState state,
    List<RoadmapStepDto> ordered,
    int index,
    int activeIndex,
    double weeklyHours,
  ) {
    final l10n = context.l10n;
    final step = ordered[index];
    final expanded = _expandedId == '${step.id}';
    final isEnrolled =
        step.courseId != null && state.enrolledCourseIds.contains(step.courseId);

    return MyPathStageCard(
      key: ValueKey('stage-${step.id}'),
      step: step,
      indexInRail: index,
      total: ordered.length,
      isExpanded: expanded,
      isCurrent: index == activeIndex,
      isEnrolled: isEnrolled,
      weeksOfStudy:
          '${(step.durationHours / weeklyHours.clamp(2, 100)).round().clamp(1, 52)} '
          '${l10n.myPathRoadmapWeeksOfStudy}',
      stageLabel: l10n.myPathRoadmapStageChip('${index + 1}'),
      statusNext: l10n.myPathRoadmapStatusNext,
      statusActive: l10n.myPathRoadmapStatusActive,
      statusDone: l10n.myPathRoadmapStatusDone,
      statusSkipped: l10n.myPathRoadmapStatusSkipped,
      purchaseLabel: l10n.myPathRoadmapPurchaseRequired,
      enrolledLabel: l10n.myPathRoadmapEnrolled,
      startLearningLabel: l10n.myPathRoadmapStartLearning,
      enrollPurchaseLabel: l10n.myPathRoadmapEnrollPurchase,
      markDoneLabel: l10n.myPathRoadmapMarkDone,
      undoLabel: l10n.myPathRoadmapUndoDone,
      skipLabel: l10n.myPathRoadmapSkipStep,
      unskipLabel: l10n.myPathRoadmapUnskip,
      reorderLabel: l10n.myPathRoadmapReorderLabel,
      moveUpTooltip: l10n.myPathRoadmapMoveUp,
      moveDownTooltip: l10n.myPathRoadmapMoveDown,
      onToggleExpand: () {
        setState(() {
          _expandedId = expanded ? null : '${step.id}';
        });
      },
      onCourseOpened: () {
        // Returning from the course screen (after enrolling/purchasing)
        // refreshes the enrollment knowledge so the chip flips state.
        context.read<MyPathCubit>().refreshRoadmap();
      },
    );
  }
}

class _EmptyRoadmap extends StatelessWidget {
  const _EmptyRoadmap();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(
            Icons.route_rounded,
            size: 42,
            color: MyPathColors.primary.withValues(alpha: .5),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.myPathRoadmapLoadingTitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: MyPathColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
