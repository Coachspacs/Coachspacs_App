import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final bool filterActive;
  final ValueChanged<bool> onFilterToggle;

  const SkillSearchBar({
    super.key,
    required this.onChanged,
    required this.filterActive,
    required this.onFilterToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE5E8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),

          const Icon(
            Icons.search,
            size: 19,
            color: Color(0xFF8FA0B8),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF172033),
              ),
              decoration: InputDecoration(
                hintText: 'Search skill (React, UI/UX, Python)...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 11,
                  color: const Color(0xFF9AA8BB),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),

          GestureDetector(
            onTap: () => onFilterToggle(!filterActive),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 7),
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: filterActive
                    ? const Color(0xFF075E4D)
                    : const Color(0xFFF1F4F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    size: 11,
                    color: filterActive
                        ? const Color(0xFFFFD98A)
                        : const Color(0xFF50627C),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'POPULAR',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: filterActive
                          ? Colors.white
                          : const Color(0xFF50627C),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
