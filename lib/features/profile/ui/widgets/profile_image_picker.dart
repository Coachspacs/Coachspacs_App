import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({
    super.key,
    this.imageUrl,
    this.onCameraPressed,
  });

  final String? imageUrl;
  final VoidCallback? onCameraPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              child: CircleAvatar(
                radius: 42,
                backgroundColor: AppColors.bgDefault,
                backgroundImage:
                imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null
                    ? const Icon(
                  Icons.person,
                  size: 45,
                  color: AppColors.textLight,
                )
                    : null,
              ),
            ),

            // Camera button
            GestureDetector(
              onTap: onCameraPressed,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.white,
                  size: 17,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        const Text(
          'Upload Profile Picture',
          style: TextStyle(
            color: AppColors.textBody,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}