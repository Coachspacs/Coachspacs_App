import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/core/theming/app_shadows.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerLowest,
        boxShadow: AppShadows.nav,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.marginMobile,
            AppDimens.stackGapSm,
            AppDimens.marginMobile,
            AppDimens.stackGapSm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
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

              _NavItem(
                icon: Icons.school_outlined,
                label: 'Courses',
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

              _NavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isActive: currentIndex == 2,
                onTap: () {
                  if (currentIndex != 2) {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.profile,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isActive,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final foreground = isActive
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurfaceVariant;

    final background = isActive
        ? colorScheme.secondaryContainer
        : Colors.transparent;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppDimens.radiusLg,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginMobile,
            vertical: AppDimens.unit,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(
              AppDimens.radiusLg,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: foreground,
              ),
              const SizedBox(
                height: AppDimens.unit,
              ),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}