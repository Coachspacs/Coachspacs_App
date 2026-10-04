import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/routing/routes.dart';
import '../../../data/models/roadmap_dtos.dart';
import '../../../logic/cubit/my_path_cubit.dart';
import 'my_path_roadmap_palette.dart';

/// One roadmap milestone — a clone of the web stage card in both of its
/// states: the big expanded card (active/selected step) and the compact
/// collapsed one (upcoming / done / skipped steps).
class MyPathStageCard extends StatelessWidget {
  const MyPathStageCard({
    super.key,
    required this.step,
    required this.indexInRail,
    required this.total,
    required this.isExpanded,
    required this.isCurrent,
    required this.isEnrolled,
    required this.weeksOfStudy,
    required this.stageLabel,
    required this.statusNext,
    required this.statusActive,
    required this.statusDone,
    required this.statusSkipped,
    required this.purchaseLabel,
    required this.enrolledLabel,
    required this.startLearningLabel,
    required this.enrollPurchaseLabel,
    required this.markDoneLabel,
    required this.undoLabel,
    required this.skipLabel,
    required this.unskipLabel,
    required this.reorderLabel,
    required this.moveUpTooltip,
    required this.moveDownTooltip,
    required this.onToggleExpand,
    this.onCourseOpened,
  });

  final RoadmapStepDto step;
  final int indexInRail;
  final int total;
  final bool isExpanded;
  final bool isCurrent;
  final bool isEnrolled;
  final String weeksOfStudy;
  final String stageLabel;
  final String statusNext;
  final String statusActive;
  final String statusDone;
  final String statusSkipped;
  final String purchaseLabel;
  final String enrolledLabel;
  final String startLearningLabel;
  final String enrollPurchaseLabel;
  final String markDoneLabel;
  final String undoLabel;
  final String skipLabel;
  final String unskipLabel;
  final String reorderLabel;
  final String moveUpTooltip;
  final String moveDownTooltip;
  final VoidCallback onToggleExpand;
  final VoidCallback? onCourseOpened;

  /// Same formula the web client uses: course hours / weekly hours, min 1.
  int weeksOfStudyCount(double weeklyHours) {
    return (step.durationHours / weeklyHours.clamp(2, 100))
        .round()
        .clamp(1, 52);
  }

  @override
  Widget build(BuildContext context) {
    final done = step.isCompleted;
    final skipped = step.isSkipped;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: .96, end: 1).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
      child: isExpanded
          ? _ExpandedCard(
              key: ValueKey('expanded-${step.id}'),
              step: step,
              indexInRail: indexInRail,
              total: total,
              done: done,
              skipped: skipped,
              isEnrolled: isEnrolled,
              stageLabel: stageLabel,
              purchaseLabel: purchaseLabel,
              enrolledLabel: enrolledLabel,
              startLearningLabel: startLearningLabel,
              enrollPurchaseLabel: enrollPurchaseLabel,
              markDoneLabel: markDoneLabel,
              undoLabel: undoLabel,
              skipLabel: skipLabel,
              unskipLabel: unskipLabel,
              reorderLabel: reorderLabel,
              moveUpTooltip: moveUpTooltip,
              moveDownTooltip: moveDownTooltip,
              onToggleExpand: onToggleExpand,
              onCourseOpened: onCourseOpened,
            )
          : _CompactCard(
              key: ValueKey('compact-${step.id}'),
              step: step,
              isDone: done,
              isSkipped: skipped,
              isActive: isCurrent,
              stageLabel: stageLabel,
              statusNext: statusNext,
              statusActive: statusActive,
              statusDone: statusDone,
              statusSkipped: statusSkipped,
              weeksLabel: weeksOfStudy,
              onToggleExpand: onToggleExpand,
            ),
    );
  }
}

// --------------------------------------------------------------------------
// EXPANDED CARD
// --------------------------------------------------------------------------
class _ExpandedCard extends StatelessWidget {
  const _ExpandedCard({
    super.key,
    required this.step,
    required this.indexInRail,
    required this.total,
    required this.done,
    required this.skipped,
    required this.isEnrolled,
    required this.stageLabel,
    required this.purchaseLabel,
    required this.enrolledLabel,
    required this.startLearningLabel,
    required this.enrollPurchaseLabel,
    required this.markDoneLabel,
    required this.undoLabel,
    required this.skipLabel,
    required this.unskipLabel,
    required this.reorderLabel,
    required this.moveUpTooltip,
    required this.moveDownTooltip,
    required this.onToggleExpand,
    this.onCourseOpened,
  });

  final RoadmapStepDto step;
  final int indexInRail;
  final int total;
  final bool done;
  final bool skipped;
  final bool isEnrolled;
  final String stageLabel;
  final String purchaseLabel;
  final String enrolledLabel;
  final String startLearningLabel;
  final String enrollPurchaseLabel;
  final String markDoneLabel;
  final String undoLabel;
  final String skipLabel;
  final String unskipLabel;
  final String reorderLabel;
  final String moveUpTooltip;
  final String moveDownTooltip;
  final VoidCallback onToggleExpand;
  final VoidCallback? onCourseOpened;

  void _openCourse(BuildContext context) {
    final courseId = step.courseId;
    if (courseId == null) {
      Navigator.pushNamed(context, AppRoutes.myLearning);
      return;
    }
    Navigator.pushNamed(context, AppRoutes.courseDetails, arguments: courseId)
        .then((_) => onCourseOpened?.call());
  }

  void _destinationAction(BuildContext context) {
    if (isEnrolled) {
      // Mobile equivalent of the web `/student/learn/{id}` link.
      Navigator.pushNamed(context, AppRoutes.myLearning);
      return;
    }
    _openCourse(context);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyPathCubit>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: done ? const Color(0xF2ECFDF5) : Colors.white,
        borderRadius: BorderRadius.circular(24),
                border: Border.all(
          color: done
              ? const Color(0xCCCCD1FA)
              : MyPathRoadmapColors.cardBorderActive,
        ),
        boxShadow: [
          BoxShadow(
            color: MyPathRoadmapColors.headerDarkMid.withValues(alpha: .20),
            blurRadius: 34,
            offset: const Offset(0, 8),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _StageChip(label: stageLabel),
                    _PurchaseChip(
                      enrolled: isEnrolled,
                      purchaseLabel: purchaseLabel,
                      enrolledLabel: enrolledLabel,
                    ),
                  ],
                ),
              ),
              _IconGhostButton(
                icon: Icons.keyboard_arrow_up_rounded,
                onTap: onToggleExpand,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.menu_book_outlined,
                size: 15,
                color: MyPathRoadmapColors.headerDarkMid,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  step.courseTitle ?? step.title ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w900,
                    height: 1.35,
                    color: MyPathRoadmapColors.slateTitle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            step.reason ?? '',
            style: GoogleFonts.inter(
              fontSize: 11.5,
              height: 1.62,
              fontWeight: FontWeight.w500,
              color: MyPathRoadmapColors.slateBody,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _GradientAction(
                icon: isEnrolled
                    ? Icons.play_arrow_rounded
                    : Icons.shopping_cart_outlined,
                label: isEnrolled ? startLearningLabel : enrollPurchaseLabel,
                onTap: () => _destinationAction(context),
              ),
              _DoneButton(
                label: done ? undoLabel : markDoneLabel,
                done: done,
                onTap: () => cubit.toggleStepCompletion(step.id),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _SkipButton(
                label: skipped ? unskipLabel : skipLabel,
                skipped: skipped,
                onTap: () => cubit.toggleStepSkip(step.id),
              ),
              const Spacer(),
              Text(
                reorderLabel,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: MyPathRoadmapColors.slateSubtle,
                ),
              ),
              const SizedBox(width: 4),
              _ArrowChip(
                icon: Icons.arrow_upward_rounded,
                enabled: indexInRail > 0,
                tooltip: moveUpTooltip,
                onTap: () => cubit.moveStep(indexInRail, up: true),
              ),
              const SizedBox(width: 4),
              _ArrowChip(
                icon: Icons.arrow_downward_rounded,
                enabled: indexInRail < total - 1,
                tooltip: moveDownTooltip,
                onTap: () => cubit.moveStep(indexInRail, up: false),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// COMPACT CARD
// --------------------------------------------------------------------------
class _CompactCard extends StatelessWidget {
  const _CompactCard({
    super.key,
    required this.step,
    required this.isDone,
    required this.isSkipped,
    required this.isActive,
    required this.stageLabel,
    required this.statusNext,
    required this.statusActive,
    required this.statusDone,
    required this.statusSkipped,
    required this.weeksLabel,
    required this.onToggleExpand,
  });

  final RoadmapStepDto step;
  final bool isDone;
  final bool isSkipped;
  final bool isActive;
  final String stageLabel;
  final String statusNext;
  final String statusActive;
  final String statusDone;
  final String statusSkipped;
  final String weeksLabel;
  final VoidCallback onToggleExpand;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDone
          ? const Color(0xE6ECFDF5)
          : isSkipped
              ? const Color(0xE6F1F5F9)
              : Colors.white.withValues(alpha: .96),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isActive
              ? const Color(0xCC10B981)
              : isDone
                  ? const Color(0x996EE7B7)
                  : const Color(0xE6E2E8F0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onToggleExpand,
        splashColor: Colors.transparent,
        highlightColor: MyPathRoadmapColors.mint.withValues(alpha: .10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: MyPathRoadmapColors.badgePendingMid
                          .withValues(alpha: .5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      stageLabel,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: MyPathRoadmapColors.stageChipText,
                      ),
                    ),
                  ),
                  const Spacer(),
                  _CompactStatus(
                    isDone: isDone,
                    isSkipped: isSkipped,
                    isActive: isActive,
                    statusNext: statusNext,
                    statusActive: statusActive,
                    statusDone: statusDone,
                    statusSkipped: statusSkipped,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.courseTitle ?? step.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          weeksLabel,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: MyPathRoadmapColors.slateSubtle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// SMALL SHARED PIECES
// --------------------------------------------------------------------------
class _CompactStatus extends StatelessWidget {
  const _CompactStatus({
    required this.isDone,
    required this.isSkipped,
    required this.isActive,
    required this.statusNext,
    required this.statusActive,
    required this.statusDone,
    required this.statusSkipped,
  });

  final bool isDone;
  final bool isSkipped;
  final bool isActive;
  final String statusNext;
  final String statusActive;
  final String statusDone;
  final String statusSkipped;

  @override
  Widget build(BuildContext context) {
    final label = isDone
        ? statusDone
        : isSkipped
            ? statusSkipped
            : isActive
                ? statusActive
                : statusNext;
    final color = isDone
        ? const Color(0xFF047857)
        : isSkipped
            ? MyPathRoadmapColors.slateSubtle
            : isActive
                ? MyPathRoadmapColors.headerDarkMid
                : const Color(0xFF94A3B8);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isActive && !isDone && !isSkipped) ...[
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyPathRoadmapColors.badgeDoneTop,
            ),
          ),
          const SizedBox(width: 4),
        ],
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: isDone ? FontWeight.w800 : FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _StageChip extends StatelessWidget {
  const _StageChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: MyPathRoadmapColors.badgePendingMid.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: MyPathRoadmapColors.badgePendingMid.withValues(alpha: .9),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: MyPathRoadmapColors.stageChipText,
        ),
      ),
    );
  }
}

class _PurchaseChip extends StatelessWidget {
  const _PurchaseChip({
    required this.enrolled,
    required this.purchaseLabel,
    required this.enrolledLabel,
  });

  final bool enrolled;
  final String purchaseLabel;
  final String enrolledLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: enrolled
            ? MyPathRoadmapColors.badgePendingMid.withValues(alpha: .7)
            : MyPathRoadmapColors.amberChipBg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: enrolled
              ? Colors.transparent
              : MyPathRoadmapColors.amberChipBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            enrolled ? Icons.check_circle : Icons.lock_outline_rounded,
            size: 10,
            color: enrolled
                ? MyPathRoadmapColors.stageChipText
                : const Color(0xFFB45309),
          ),
          const SizedBox(width: 4),
          Text(
            enrolled ? enrolledLabel : purchaseLabel,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: enrolled
                  ? MyPathRoadmapColors.stageChipText
                  : MyPathRoadmapColors.amberChipText,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconGhostButton extends StatelessWidget {
  const _IconGhostButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 22,
      splashColor: Colors.transparent,
      highlightColor: const Color(0xFFF1F5F9),
      child: Icon(icon, size: 16, color: MyPathRoadmapColors.slateSubtle),
    );
  }
}

class _GradientAction extends StatelessWidget {
  const _GradientAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white24,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [
                MyPathRoadmapColors.cardBtnTop,
                MyPathRoadmapColors.cardBtnBottom,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: MyPathRoadmapColors.headerDarkMid.withValues(alpha: .25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 13, color: MyPathRoadmapColors.mint),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({
    required this.label,
    required this.done,
    required this.onTap,
  });

  final String label;
  final bool done;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: done ? const Color(0xFFF1F5F9) : const Color(0xFFECFDF5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: done
              ? const Color(0xFFCBD5E1)
              : MyPathRoadmapColors.badgePendingMid.withValues(alpha: .8),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: done
                  ? const Color(0xFF334155)
                  : MyPathRoadmapColors.headerDarkMid,
            ),
          ),
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({
    required this.label,
    required this.skipped,
    required this.onTap,
  });

  final String label;
  final bool skipped;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              skipped ? Icons.undo_rounded : Icons.skip_next_outlined,
              size: 12,
              color: const Color(0xFF64748B),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowChip extends StatelessWidget {
  const _ArrowChip({
    required this.icon,
    required this.enabled,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: 22,
      height: 19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: enabled ? const Color(0xFFCBD5E1) : Colors.transparent,
        ),
        color: enabled ? const Color(0xFFF8FAFC) : Colors.transparent,
      ),
      child: Icon(
        icon,
        size: 11,
        color: enabled ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
      ),
    );
    return Tooltip(
      message: tooltip,
      preferBelow: false,
      margin: const EdgeInsets.all(4),
      child: enabled
          ? InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(5),
              splashColor: Colors.transparent,
              highlightColor: MyPathRoadmapColors.badgePendingMid,
              child: box,
            )
          : Opacity(opacity: .6, child: box),
    );
  }
}
