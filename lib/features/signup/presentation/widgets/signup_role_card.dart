import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class SignupRoleCard extends StatelessWidget {
  const SignupRoleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 105,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(
            alpha: 0.08,
          )
              : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.borderColor,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 34,
              color: selected
                  ? AppColors.primary
                  : AppColors.textLight,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: selected
                    ? AppColors.primary
                    : AppColors.textLight,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}