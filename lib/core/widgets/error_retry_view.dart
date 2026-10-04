import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';

/// Full-width failure state with a retry action.
///
/// Rendered inside a scrollable (usually wrapped in a `RefreshIndicator`)
/// by cart, order history, checkout, catalog and instructor students.
class ErrorRetryView extends StatelessWidget {
  const ErrorRetryView({
    super.key,
    required this.title,
    required this.onRetry,
    this.detail,
    this.iconSize = 46,
  });

  final String title;
  final String? detail;
  final VoidCallback onRetry;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.error_outline_rounded,
          size: iconSize,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 14),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),
        if (detail != null) ...[
          const SizedBox(height: 6),
          Text(
            detail!,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              color: const Color(0xFF71827E),
            ),
          ),
        ],
        const SizedBox(height: 18),
        Center(
          child: SizedBox(
            height: 42,
            child: ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 17),
              label: Text(
                context.l10n.commonRetry,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
