import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class ProfileTopBar extends StatelessWidget {
  const ProfileTopBar({
    super.key,
    this.onNotificationPressed,
  });

  final VoidCallback? onNotificationPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/Logo_img.png',
            width: 32,
            height: 32,
            fit: BoxFit.contain,
          ),

          const SizedBox(width: 8),

          const Text(
            'Coach Space',
            style: TextStyle(
              color: AppColors.textBody,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const Spacer(),

          IconButton(
            onPressed: onNotificationPressed,
            icon: const Icon(
              Icons.notifications_none_outlined,
              size: 22,
            ),
            color: AppColors.textLight,
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}