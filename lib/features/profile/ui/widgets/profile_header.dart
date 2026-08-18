import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onBack,
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
          color: AppColors.textBody,
        ),
        const Expanded(
          child: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textBody,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}