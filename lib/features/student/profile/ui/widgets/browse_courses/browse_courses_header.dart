import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';

class BrowseCoursesHeader extends StatelessWidget {
  const BrowseCoursesHeader({
    super.key,
    required this.selectedStatus,
    required this.allCount,
    required this.inProgressCount,
    required this.completedCount,
    required this.onStatusChanged,
  });

  final CourseFilter selectedStatus;
  final int allCount;
  final int inProgressCount;
  final int completedCount;
  final ValueChanged<CourseFilter> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final filterOptions = [
      (filter: CourseFilter.all, label: l10n.homeAll, count: allCount),
      (
        filter: CourseFilter.inProgress,
        label: l10n.myLearningInProgress,
        count: inProgressCount,
      ),
      (
        filter: CourseFilter.completed,
        label: l10n.myLearningCompleted,
        count: completedCount,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.maybePop(context),
              tooltip: l10n.browseBack,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 23,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                l10n.myLearningMyCourses,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          l10n.browseCoursesSubtitle,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: const Color(0xFF71827E),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFDCE8E4)),
          ),
          child: Row(
            children: filterOptions
                .map(
                  (option) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: option.filter == CourseFilter.completed ? 0 : 4,
                      ),
                      child: _FilterButton(
                        label: option.label,
                        count: option.count,
                        isSelected: selectedStatus == option.filter,
                        onTap: () => onStatusChanged(option.filter),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

enum CourseFilter { all, inProgress, completed }

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: '$label ($count)',
      child: Material(
        color: isSelected ? const Color(0xFFCFF5E3) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 39,
            child: Center(
              child: Text(
                '$label ($count)',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF075E4D)
                      : const Color(0xFF52635F),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
