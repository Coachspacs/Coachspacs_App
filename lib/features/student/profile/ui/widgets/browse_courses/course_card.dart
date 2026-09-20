import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.title,
    required this.instructor,
    required this.progressPercent,
    required this.isCompleted,
    required this.onPressed,
    this.coverImage = '',
    this.onCertificatePressed,
  });

  final String title;
  final String instructor;
  final String coverImage;
  final int progressPercent;
  final bool isCompleted;
  final VoidCallback onPressed;
  final VoidCallback? onCertificatePressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final normalizedProgress = (progressPercent / 100).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCE8E4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _cover(),
                  if (!isCompleted)
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '$progressPercent%',
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF075E4D),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: const Color(0xFF073F38),
              fontSize: 14,
              height: 1.25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            instructor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: const Color(0xFF71827E),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isCompleted
                    ? l10n.myLearningCompleted
                    : l10n.browseCourseProgress,
                style: GoogleFonts.inter(
                  color: const Color(0xFF71827E),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$progressPercent%',
                style: GoogleFonts.inter(
                  color: const Color(0xFF075E4D),
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: normalizedProgress,
              minHeight: 5,
              backgroundColor: const Color(0xFFE8EFED),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton.icon(
              onPressed: onPressed,
              icon: Icon(
                isCompleted
                    ? Icons.check_circle_outline
                    : Icons.play_arrow_rounded,
                size: 16,
              ),
              label: Text(
                isCompleted
                    ? l10n.myLearningCompleted
                    : l10n.myLearningContinue,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          if (isCompleted && onCertificatePressed != null) ...[
            const SizedBox(height: 7),
            SizedBox(
              width: double.infinity,
              height: 34,
              child: OutlinedButton.icon(
                onPressed: onCertificatePressed,
                icon: const Icon(Icons.workspace_premium_outlined, size: 14),
                label: Text(
                  l10n.browseViewCertificate,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF075E4D),
                  side: const BorderSide(color: Color(0xFFBFE9D8)),
                  backgroundColor: const Color(0xFFEAF8F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _cover() {
    final url = coverImage.trim();
    if (url.isEmpty) {
      return Container(
        color: const Color(0xFFF0F6F4),
        alignment: Alignment.center,
        child: const Icon(
          Icons.play_circle_outline,
          size: 40,
          color: Color(0xFF53615E),
        ),
      );
    }

    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Container(
        color: const Color(0xFFF0F6F4),
        alignment: Alignment.center,
        child: const Icon(
          Icons.play_circle_outline,
          size: 40,
          color: Color(0xFF53615E),
        ),
      ),
    );
  }
}
