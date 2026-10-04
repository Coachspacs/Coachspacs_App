import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

/// Empty-state card: circular icon badge, bold title, muted hint and an
/// optional call-to-action button.
///
/// Used by cart, order history, checkout, catalog and instructor students.
class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    required this.icon,
    required this.title,
    this.hint,
    this.ctaLabel,
    this.onCta,
    this.ctaIcon,
    this.iconBadgeSize = 46,
    this.iconSize = 22,
    this.titleFontSize = 14,
    this.hintFontSize = 11,
  });

  final IconData icon;
  final String title;
  final String? hint;
  final String? ctaLabel;
  final VoidCallback? onCta;
  final IconData? ctaIcon;
  final double iconBadgeSize;
  final double iconSize;
  final double titleFontSize;
  final double hintFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0EAE7)),
      ),
      child: Column(
        children: [
          Container(
            width: iconBadgeSize,
            height: iconBadgeSize,
            decoration: const BoxDecoration(
              color: Color(0xFFE4F6F0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: iconSize,
              color: const Color(0xFF075E4D),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF073F38),
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (hint != null) ...[
            const SizedBox(height: 5),
            Text(
              hint!,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF71827E),
                fontSize: hintFontSize,
              ),
            ),
          ],
          if (ctaLabel != null && onCta != null) ...[
            const SizedBox(height: 18),
            SizedBox(
              height: 44,
              child: ElevatedButton.icon(
                onPressed: onCta,
                icon: Icon(ctaIcon ?? Icons.arrow_forward_rounded, size: 17),
                label: Text(
                  ctaLabel!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
