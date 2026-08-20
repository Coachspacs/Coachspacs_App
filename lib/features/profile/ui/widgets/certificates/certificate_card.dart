import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class CertificateCard extends StatelessWidget {
  const CertificateCard({
    super.key,
    required this.courseTitle,
    required this.certificateId,
    required this.onDownload,
  });

  final String courseTitle;
  final String certificateId;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.successLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium_outlined,
              color: AppColors.primary,
              size: 28,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            courseTitle,
            style: const TextStyle(
              color: AppColors.textBody,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            certificateId,
            style: const TextStyle(
              color: AppColors.textLight,
              fontSize: 10,
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton.icon(
              onPressed: onDownload,
              icon: const Icon(
                Icons.download_outlined,
                size: 17,
              ),
              label: const Text(
                'Download PDF',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}