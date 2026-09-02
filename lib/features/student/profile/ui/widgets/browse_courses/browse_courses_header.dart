import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        // =====================================================
        // BACK BUTTON + TITLE
        // =====================================================

        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 30,
                minHeight: 30,
              ),
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 23,
                color: Color(0xFF073F38),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                'My Courses',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF073F38),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Text(
          'Continue your learning journey',
          style: GoogleFonts.inter(
            fontSize: 11,
            color: const Color(0xFF71827E),
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(height: 16),

        // =====================================================
        // FILTER TABS
        // =====================================================

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: const Color(0xFFDCE8E4),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _FilterButton(
                  title: 'All',
                  count: allCount,
                  isSelected:
                  selectedStatus == CourseFilter.all,
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
                    onStatusChanged(
                      CourseFilter.inProgress,
                    );
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
                    onStatusChanged(
                      CourseFilter.completed,
                    );
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

// =========================================================
// FILTER
// =========================================================

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
          ? const Color(0xFFCFF5E3)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 39,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          child: Text(
            '$title ($count)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: isSelected
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF075E4D)
                  : const Color(0xFF52635F),
            ),
          ),
        ),
      ),
    );
  }
}