import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          // Certificate icon
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFDDF5EA),
              borderRadius: BorderRadius.circular(27),
            ),
            child: const Icon(
              Icons.workspace_premium_outlined,
              size: 28,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: 18),

          // Certificate title
          Text(
            courseTitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: AppColors.textBody,
              fontSize: 16,
              height: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          // Certificate ID label
          Text(
            'Certificate ID',
            style: GoogleFonts.inter(
              color: AppColors.textLight,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 4),

          // Certificate ID
          Text(
            certificateId,
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          // Divider
          const Divider(
            height: 1,
            color: AppColors.border,
          ),

          const SizedBox(height: 16),

          // Certificate information
          Row(
            children: [
              Expanded(
                child: _CertificateInfo(
                  icon: Icons.calendar_today_outlined,
                  label: 'Issued Date',
                  value: 'May 12, 2024',
                ),
              ),

              Container(
                width: 1,
                height: 38,
                color: AppColors.border,
              ),

              const SizedBox(width: 16),

              Expanded(
                child: _CertificateInfo(
                  icon: Icons.verified_outlined,
                  label: 'Issued By',
                  value: 'Coach Space',
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Download button
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: onDownload,
              icon: const Icon(
                Icons.download_outlined,
                size: 18,
              ),
              label: Text(
                'Download PDF',
                style: GoogleFonts.inter(
                  fontSize: 11,
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

          const SizedBox(height: 10),

          Center(
            child: Text(
              'Verified certificate • Coach Space',
              style: GoogleFonts.inter(
                color: AppColors.textLight,
                fontSize: 8.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CertificateInfo extends StatelessWidget {
  const _CertificateInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F6F1),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(
            icon,
            size: 17,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  color: AppColors.textLight,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: AppColors.textBody,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}