import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/roadmap_dtos.dart';
import '../../../logic/cubit/my_path_cubit.dart';
import 'my_path_roadmap_palette.dart';

/// Bottom sheet reordered — the mobile clone of the web "Reorder Roadmap
/// Stages" modal: numbered rows with up/down arrows that patch the server
/// order instantly.
class MyPathReorderSheet extends StatelessWidget {
  const MyPathReorderSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.completedLabel,
    required this.skippedLabel,
    required this.noteLabel,
    required this.saveLabel,
  });

  final String title;
  final String subtitle;
  final String completedLabel;
  final String skippedLabel;
  final String noteLabel;
  final String saveLabel;

  static Future<void> show(
    BuildContext context, {
    required String Function(String) labels,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: context.read<MyPathCubit>(),
        child: MyPathReorderSheet(
          title: labels('title'),
          subtitle: labels('subtitle'),
          completedLabel: labels('completed'),
          skippedLabel: labels('skipped'),
          noteLabel: labels('note'),
          saveLabel: labels('save'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPathCubit, MyPathState>(
      builder: (context, state) {
        final steps = state.roadmap?.orderedSteps ?? const <RoadmapStepDto>[];
        final activeIndex =
            state.roadmap?.currentActiveIndex ?? 0;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * .78,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      MyPathRoadmapColors.headerDarkMid,
                      MyPathRoadmapColors.badgeCurrentMid,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .10),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .2),
                        ),
                      ),
                      child: const Icon(
                        Icons.swap_vert_rounded,
                        size: 20,
                        color: MyPathRoadmapColors.mint,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xCCA7F3D0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkResponse(
                      onTap: () => Navigator.pop(context),
                      radius: 22,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.white.withValues(alpha: .15),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      for (var i = 0; i < steps.length; i++)
                        _ReorderRow(
                          step: steps[i],
                          index: i,
                          total: steps.length,
                          isActive: i == activeIndex,
                          completedLabel: completedLabel,
                          skippedLabel: skippedLabel,
                          onMove: (up) =>
                              context.read<MyPathCubit>().moveStep(i, up: up),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  border: Border(
                    top: BorderSide(color: Color(0xFFF1F5F9)),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        noteLabel,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(12),
                        splashColor: Colors.transparent,
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [
                                MyPathRoadmapColors.cardBtnTop,
                                MyPathRoadmapColors.cardBtnBottom,
                              ],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x40105244),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 9,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                saveLabel,
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReorderRow extends StatelessWidget {
  const _ReorderRow({
    required this.step,
    required this.index,
    required this.total,
    required this.isActive,
    required this.completedLabel,
    required this.skippedLabel,
    required this.onMove,
  });

  final RoadmapStepDto step;
  final int index;
  final int total;
  final bool isActive;
  final String completedLabel;
  final String skippedLabel;
  final ValueChanged<bool> onMove;

  @override
  Widget build(BuildContext context) {
    final done = step.isCompleted;
    final skipped = step.isSkipped;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xF2ECFDF5)
            : done
                ? const Color(0xFFFAFBFB)
                : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? const Color(0xE634D399)
              : done
                  ? const Color(0x996EE7B7)
                  : const Color(0xFFCBD5E1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: MyPathRoadmapColors.headerDarkMid,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              _padded(index + 1),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.courseTitle ?? step.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    if (done) ...[
                      const Icon(
                        Icons.check_circle,
                        size: 12,
                        color: Color(0xFF047857),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        completedLabel,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF047857),
                        ),
                      ),
                    ] else if (skipped) ...[
                      const Icon(
                        Icons.remove_circle_outline_rounded,
                        size: 12,
                        color: Color(0xFF94A3B8),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        skippedLabel,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: MyPathRoadmapColors.slateSubtle,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _MoveChip(
            icon: Icons.arrow_upward_rounded,
            enabled: index > 0,
            onTap: () => onMove(true),
          ),
          const SizedBox(width: 6),
          _MoveChip(
            icon: Icons.arrow_downward_rounded,
            enabled: index < total - 1,
            onTap: () => onMove(false),
          ),
        ],
      ),
    );
  }
}

String _padded(int n) => n < 10 ? '0$n' : '$n';

class _MoveChip extends StatelessWidget {
  const _MoveChip({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: enabled ? const Color(0xFFCBD5E1) : Colors.transparent,
        ),
        color: enabled ? const Color(0xFFF8FAFC) : Colors.transparent,
      ),
      child: Icon(
        icon,
        size: 15,
        color: enabled
            ? const Color(0xFF334155)
            : const Color(0xFFCBD5E1),
      ),
    );
    return enabled
        ? InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.transparent,
            highlightColor: MyPathRoadmapColors.badgePendingMid,
            child: box,
          )
        : Opacity(opacity: .4, child: box);
  }
}
