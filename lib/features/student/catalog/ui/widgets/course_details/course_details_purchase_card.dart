import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

class CourseDetailsPurchaseCard extends StatelessWidget {
  const CourseDetailsPurchaseCard({
    super.key,
    required this.price,
    required this.isFree,
    required this.isEnrolled,
    this.isBusy = false,
    this.onAddToCart,
    this.onBuyNow,
    this.onEnrollFree,
    this.onContinue,
  });

  final String price;
  final bool isFree;
  final bool isEnrolled;
  final bool isBusy;
  final VoidCallback? onAddToCart;
  final VoidCallback? onBuyNow;
  final VoidCallback? onEnrollFree;
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCE8E4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isEnrolled) ...[
            Row(
              children: [
                const Icon(
                  Icons.verified_rounded,
                  size: 22,
                  color: Color(0xFF075E4D),
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.courseDetailsAlreadyEnrolled,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF075E4D),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l10n.courseDetailsContinueLearning,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: const Color(0xFF71827E),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: onContinue,
                icon: const Icon(Icons.play_arrow_rounded, size: 20),
                label: Text(
                  l10n.courseDetailsContinue,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF075E4D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ] else if (isFree) ...[
            Text(
              l10n.catalogFree,
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF075E4D),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: isBusy ? null : onEnrollFree,
                icon: isBusy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.play_arrow_rounded, size: 18),
                label: Text(
                  l10n.courseDetailsEnrollFree,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF075E4D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ] else ...[
            Text(
              price,
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF075E4D),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 46,
              child: ElevatedButton.icon(
                onPressed: isBusy ? null : onAddToCart,
                icon: isBusy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.shopping_cart_outlined, size: 18),
                label: Text(
                  l10n.courseDetailsAddToCart,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF075E4D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 9),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton(
                onPressed: isBusy ? null : onBuyNow,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF075E4D),
                  side: const BorderSide(
                    color: Color(0xFF075E4D),
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
                child: Text(
                  l10n.courseDetailsBuyNow,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                l10n.courseDetailsMoneyBack,
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF899792),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}