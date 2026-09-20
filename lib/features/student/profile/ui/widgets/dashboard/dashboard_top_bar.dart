import 'package:flutter/material.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/user_avatar.dart';

class DashboardTopBar extends StatelessWidget {
  const DashboardTopBar({
    super.key,
    this.onNotificationPressed,
    this.onProfilePressed,
  });

  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/Logo_img.png',
            width: 32,
            height: 32,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Icon(
              Icons.auto_awesome,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            context.l10n.appTitle,
            style: const TextStyle(
              color: AppColors.textBody,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onNotificationPressed,
            icon: const Icon(Icons.notifications_none_outlined, size: 22),
            color: AppColors.textLight,
          ),
          GestureDetector(
            onTap: onProfilePressed,
            child: const UserAvatar(size: 34),
          ),
        ],
      ),
    );
  }
}
