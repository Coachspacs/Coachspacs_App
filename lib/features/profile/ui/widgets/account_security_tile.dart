import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class AccountSecurityTile extends StatelessWidget {
  const AccountSecurityTile({
    super.key,
    required this.onChangePassword,
  });

  final VoidCallback onChangePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.bgDefault,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.lock_outline,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Account Security',
              style: TextStyle(
                color: AppColors.textBody,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: onChangePassword,
            child: const Text(
              'Change Password',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textLight,
            size: 20,
          ),
        ],
      ),
    );
  }
}