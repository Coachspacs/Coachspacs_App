import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/option_tile.dart';

class ChangeProfilePictureBottomSheet extends StatelessWidget {
  const ChangeProfilePictureBottomSheet({
    super.key,
    required this.onTakePhoto,
    required this.onPickFromGallery,
  });

  final VoidCallback onTakePhoto;
  final VoidCallback onPickFromGallery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Change Profile Picture',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textBody,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Choose how to update your photo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                OptionTile(
                  icon: Icons.camera_alt_outlined,
                  title: 'Take a Photo',
                  onTap: onTakePhoto,
                  iconColor: AppColors.primary,
                ),
                const SizedBox(width: 12),
                OptionTile(
                  icon: Icons.image_outlined,
                  title: 'Upload from Gallery',
                  onTap: onPickFromGallery,
                  iconColor: AppColors.secondary,
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}