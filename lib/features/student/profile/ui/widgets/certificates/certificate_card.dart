import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';

class CertificateCard extends StatelessWidget {
  const CertificateCard({
    super.key,
    required this.certificate,
    required this.onDownload,
    required this.onShare,
    this.isBusy = false,
  });

  final CertificateDto certificate;
  final VoidCallback onDownload;
  final VoidCallback onShare;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final issuedOn = DateFormat.yMMMd().format(certificate.issuedAt);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
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

          // Course title
          Text(
            certificate.course.title,
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

          // Certificate number label
          Text(
            l10n.certificatesNumber,
            style: GoogleFonts.inter(
              color: AppColors.textLight,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 4),

          // Certificate number
          Text(
            certificate.certificateNumber,
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          // Divider
          const Divider(height: 1, color: AppColors.border),

          const SizedBox(height: 16),

          // Certificate information
          Row(
            children: [
              Expanded(
                child: _CertificateInfo(
                  icon: Icons.calendar_today_outlined,
                  label: l10n.certificatesIssuedOn,
                  value: issuedOn,
                ),
              ),

              Container(width: 1, height: 38, color: AppColors.border),

              const SizedBox(width: 16),

              Expanded(
                child: _CertificateInfo(
                  icon: Icons.person_outline_rounded,
                  label: l10n.certificatesStudentName,
                  value: certificate.studentName,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Actions
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: isBusy ? null : onDownload,
                    icon: isBusy
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.white,
                            ),
                          )
                        : const Icon(Icons.download_outlined, size: 18),
                    label: Text(
                      isBusy
                          ? l10n.certificatesDownloading
                          : l10n.certificatesDownload,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      disabledBackgroundColor: AppColors.primary,
                      disabledForegroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: SizedBox(
                  height: 44,
                  child: OutlinedButton.icon(
                    onPressed: isBusy ? null : onShare,
                    icon: const Icon(Icons.share_outlined, size: 17),
                    label: Text(
                      l10n.certificatesShare,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
          child: Icon(icon, size: 17, color: AppColors.primary),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
