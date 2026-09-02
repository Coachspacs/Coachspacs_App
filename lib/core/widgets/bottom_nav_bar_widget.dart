import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_shadows.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  static const Color primaryColor =
  Color(0xFF0F766E);

  static const Color activeBackground =
  Color(0xFFDDF3EE);

  static const Color inactiveColor =
  Color(0xFF354640);

  // =====================================================
  // CHECK GUEST ACCESS
  // =====================================================

  void _handleProtectedNavigation(
      BuildContext context,
      String route,
      ) {
    if (GuestSession.isGuest) {
      LoginRequiredDialog.show(context);
      return;
    }

    if (currentIndex != _getRouteIndex(route)) {
      Navigator.pushReplacementNamed(
        context,
        route,
      );
    }
  }

  int _getRouteIndex(String route) {
    switch (route) {
      case AppRoutes.home:
        return 0;

      case AppRoutes.catalog:
        return 1;

      case AppRoutes.myLearning:
        return 2;

      case AppRoutes.profile:
        return 3;

      default:
        return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppShadows.nav,
        borderRadius:
        const BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [
              // =========================================
              // HOME
              // =========================================

              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () {
                  if (currentIndex != 0) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.home,
                    );
                  }
                },
              ),

              // =========================================
              // CATALOG
              // =========================================

              _NavItem(
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: 'Catalog',
                isActive: currentIndex == 1,
                onTap: () {
                  if (currentIndex != 1) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.catalog,
                    );
                  }
                },
              ),

              // =========================================
              // MY LEARNING - PROTECTED
              // =========================================

              _NavItem(
                icon: Icons.menu_book_outlined,
                activeIcon: Icons.menu_book,
                label: 'My Learning',
                isActive: currentIndex == 2,
                onTap: () {
                  _handleProtectedNavigation(
                    context,
                    AppRoutes.myLearning,
                  );
                },
              ),

              // =========================================
              // PROFILE - PROTECTED
              // =========================================

              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                isActive: currentIndex == 3,
                onTap: () {
                  _handleProtectedNavigation(
                    context,
                    AppRoutes.profile,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// NAV ITEM
// =====================================================

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.onTap,
    required this.isActive,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  static const Color primaryColor =
  Color(0xFF0F766E);

  static const Color activeBackground =
  Color(0xFFDDF3EE);

  static const Color inactiveColor =
  Color(0xFF354640);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
        BorderRadius.circular(14),
        child: AnimatedContainer(
          duration:
          const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          width: 78,
          height: 50,
          padding:
          const EdgeInsets.symmetric(
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
            mainAxisSize: MainAxisSize.min,
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

              const SizedBox(height: 2),

              Text(
                label,
                maxLines: 1,
                overflow:
                TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 9.5,
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