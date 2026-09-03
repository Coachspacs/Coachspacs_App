import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorCoursesFilter
    extends StatelessWidget {
  const InstructorCoursesFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final CourseFilter selectedFilter;
  final ValueChanged<CourseFilter>
  onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterItem(
            label: 'All',
            filter: CourseFilter.all,
            selectedFilter: selectedFilter,
            onTap: onFilterChanged,
          ),

          _FilterItem(
            label: 'Active',
            filter: CourseFilter.active,
            selectedFilter: selectedFilter,
            onTap: onFilterChanged,
          ),

          _FilterItem(
            label: 'Pending',
            filter: CourseFilter.pending,
            selectedFilter: selectedFilter,
            onTap: onFilterChanged,
          ),

          _FilterItem(
            label: 'Published',
            filter: CourseFilter.published,
            selectedFilter: selectedFilter,
            onTap: onFilterChanged,
          ),

          _FilterItem(
            label: 'Drafts',
            filter: CourseFilter.drafts,
            selectedFilter: selectedFilter,
            onTap: onFilterChanged,
          ),
        ],
      ),
    );
  }
}

// =====================================================
// FILTER ITEM
// =====================================================

class _FilterItem extends StatelessWidget {
  const _FilterItem({
    required this.label,
    required this.filter,
    required this.selectedFilter,
    required this.onTap,
  });

  final String label;
  final CourseFilter filter;
  final CourseFilter selectedFilter;
  final ValueChanged<CourseFilter> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected =
        filter == selectedFilter;

    return Padding(
      padding:
      const EdgeInsets.only(right: 7),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
          BorderRadius.circular(20),
          onTap: () => onTap(filter),
          child: AnimatedContainer(
            duration:
            const Duration(milliseconds: 180),
            padding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF075E4D)
                  : Colors.white,
              borderRadius:
              BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF075E4D)
                    : const Color(0xFFDCE7E4),
              ),
            ),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? Colors.white
                    : const Color(0xFF64736F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// FILTER ENUM
// =====================================================

enum CourseFilter {
  all,
  active,
  pending,
  published,
  drafts,
}