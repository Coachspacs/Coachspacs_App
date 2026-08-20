import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enrolled Courses',
          style: TextStyle(
            color: AppColors.textBody,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 16),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _FilterButton(
                  title: 'All',
                  count: allCount,
                  isSelected: selectedStatus == CourseFilter.all,
                  onTap: () {
                    onStatusChanged(CourseFilter.all);
                  },
                ),
              ),

              const SizedBox(width: 4),

              Expanded(
                child: _FilterButton(
                  title: 'In Progress',
                  count: inProgressCount,
                  isSelected:
                  selectedStatus == CourseFilter.inProgress,
                  onTap: () {
                    onStatusChanged(CourseFilter.inProgress);
                  },
                ),
              ),

              const SizedBox(width: 4),

              Expanded(
                child: _FilterButton(
                  title: 'Completed',
                  count: completedCount,
                  isSelected:
                  selectedStatus == CourseFilter.completed,
                  onTap: () {
                    onStatusChanged(CourseFilter.completed);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum CourseFilter {
  all,
  inProgress,
  completed,
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.title,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColors.successLight
          : AppColors.white,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          height: 38,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
          ),
          child: Text(
            '$title ($count)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textLight,
              fontSize: 11,
              fontWeight: isSelected
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}