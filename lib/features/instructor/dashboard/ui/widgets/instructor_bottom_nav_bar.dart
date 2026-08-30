import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorBottomNavBar extends StatelessWidget {
  const InstructorBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onItemSelected,
  });

  final int currentIndex;
  final ValueChanged<int>? onItemSelected;

  static const Color primaryColor =
  Color(0xFF075E4D);

  static const Color activeBackground =
  Color(0xFFDDF3EB);

  static const Color inactiveColor =
  Color(0xFF667570);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(
            color: Color(0xFFE2EBE8),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              _NavItem(
                icon: Icons.dashboard_outlined,
                activeIcon: Icons.dashboard_rounded,
                label: 'Dashboard',
                isActive: currentIndex == 0,
                onTap: () {
                  onItemSelected?.call(0);
                },
              ),

              _NavItem(
                icon: Icons.menu_book_outlined,
                activeIcon: Icons.menu_book_rounded,
                label: 'Courses',
                isActive: currentIndex == 1,
                onTap: () {
                  onItemSelected?.call(1);
                },
              ),

              _NavItem(
                icon: Icons.people_outline_rounded,
                activeIcon: Icons.people_rounded,
                label: 'Students',
                isActive: currentIndex == 2,
                onTap: () {
                  onItemSelected?.call(2);
                },
              ),

              _NavItem(
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                label: 'Profile',
                isActive: currentIndex == 3,
                onTap: () {
                  onItemSelected?.call(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// NAV ITEM
// =============================================================

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  static const Color primaryColor =
  Color(0xFF075E4D);

  static const Color activeBackground =
  Color(0xFFDDF3EB);

  static const Color inactiveColor =
  Color(0xFF667570);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration:
          const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: 76,
          height: 52,
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: isActive
                ? activeBackground
                : Colors.transparent,
            borderRadius:
            BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                isActive
                    ? activeIcon
                    : icon,
                size: 21,
                color: isActive
                    ? primaryColor
                    : inactiveColor,
              ),

              const SizedBox(height: 3),

              Text(
                label,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 8.5,
                  fontWeight: isActive
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: isActive
                      ? primaryColor
                      : inactiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}