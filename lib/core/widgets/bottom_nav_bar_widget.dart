import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_shadows.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';

enum NavType { student, instructor }

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.navType,
    this.onItemSelected,
  });

  final int currentIndex;
  final NavType navType;
  final ValueChanged<int>? onItemSelected;

  static const Color primaryColor = Color(0xFF0F766E);
  static const Color activeBackground = Color(0xFFDDF3EE);
  static const Color inactiveColor = Color(0xFF354640);

  @override
  Widget build(BuildContext context) {
    // =====================================================
    // GET ROUTE INDEX FOR INSTRUCTOR ONITEMISELECTED
    // =====================================================

    int getRouteIndex(String route) {
      switch (navType) {
        case NavType.student:
          switch (route) {
            case AppRoutes.home: return 0;
            case AppRoutes.catalog: return 1;
            case AppRoutes.myLearning: return 2;
            case AppRoutes.profile: return 3;
            default: return -1;
          }
        case NavType.instructor:
          switch (route) {
            case AppRoutes.instructorDashboard: return 0;
            case AppRoutes.instructorCourses: return 1;
            case AppRoutes.instructorStudents: return 2;
            case AppRoutes.instructorProfile: return 3;
            default: return -1;
          }
      }
    }

    // =====================================================
    // HANDLE PROTECTED NAVIGATION (has access to context)
    // =====================================================

    void handleProtectedNavigation(String route) {
      if (GuestSession.isGuest) {
        LoginRequiredDialog.show(context);
        return;
      }

      if (onItemSelected != null) {
        onItemSelected!(getRouteIndex(route));
      } else {
        Navigator.pushReplacementNamed(context, route);
      }
    }

    // =====================================================
    // BUILD NAV ITEM WIDGET
    // =====================================================

    Widget buildNavItem({
      required IconData icon,
      required IconData activeIcon,
      required String label,
      required bool isActive,
      required VoidCallback onTap,
    }) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: 78,
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: isActive ? activeBackground : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isActive ? activeIcon : icon,
                  size: 21,
                  color: isActive ? primaryColor : inactiveColor,
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                    color: isActive ? primaryColor : inactiveColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // =====================================================
    // BUILD NAV ITEMS BASED ON TYPE
    // =====================================================

    List<Widget> navItems;
    switch (navType) {
      case NavType.student:
        // Student nav items use handleProtectedNavigation (shows login dialog if guest)
        navItems = [
          buildNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => handleProtectedNavigation(AppRoutes.home),
          ),
          buildNavItem(
            icon: Icons.explore_outlined,
            activeIcon: Icons.explore,
            label: 'Catalog',
            isActive: currentIndex == 1,
            onTap: () => handleProtectedNavigation(AppRoutes.catalog),
          ),
          buildNavItem(
            icon: Icons.menu_book_outlined,
            activeIcon: Icons.menu_book,
            label: 'My Learning',
            isActive: currentIndex == 2,
            onTap: () => handleProtectedNavigation(AppRoutes.myLearning),
          ),
          buildNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            isActive: currentIndex == 3,
            onTap: () => handleProtectedNavigation(AppRoutes.profile),
          ),
        ];
        break;
      case NavType.instructor:
        // Instructor nav items use onItemSelected callback
        navItems = [
          buildNavItem(
            icon: Icons.dashboard_outlined,
            activeIcon: Icons.dashboard_rounded,
            label: 'Dashboard',
            isActive: currentIndex == 0,
            onTap: () => onItemSelected?.call(0),
          ),
          buildNavItem(
            icon: Icons.menu_book_outlined,
            activeIcon: Icons.menu_book_rounded,
            label: 'Courses',
            isActive: currentIndex == 1,
            onTap: () => onItemSelected?.call(1),
          ),
          buildNavItem(
            icon: Icons.people_outline_outlined,
            activeIcon: Icons.people_rounded,
            label: 'Students',
            isActive: currentIndex == 2,
            onTap: () => onItemSelected?.call(2),
          ),
          buildNavItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
            isActive: currentIndex == 3,
            onTap: () => onItemSelected?.call(3),
          ),
        ];
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadows.nav,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: navItems,
          ),
        ),
      ),
    );
  }
}