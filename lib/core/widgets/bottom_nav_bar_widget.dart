import 'package:flutter/material.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_dimens.dart';
import 'package:coach_space/core/theming/app_shadows.dart';

/// Fixed bottom navigation (Home · Courses · Search · Profile).
///
/// The Home tab (الرئيسية, index 0) renders as the active pill while the
/// Home screen is shown; the mockup's Search highlight was a placeholder.
class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
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
                label: l10n.navHome,
                isActive: true,
                onTap: () {},
              ),
              _NavItem(
                icon: Icons.school_outlined,
                label: l10n.navCourses,
                onTap: () {},
              ),
              _NavItem(icon: Icons.search, label: l10n.navSearch, onTap: () {}),
              _NavItem(
                icon: Icons.person_outline,
                label: l10n.navProfile,
                onTap: () {},
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
    this.isActive = false,
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
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.marginMobile,
            vertical: AppDimens.unit,
          ),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: foreground),
              const SizedBox(height: AppDimens.unit),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
