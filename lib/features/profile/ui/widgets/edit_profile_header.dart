import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class EditProfileHeader extends StatelessWidget {
  const EditProfileHeader({
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
            'Edit Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textBody,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }
}