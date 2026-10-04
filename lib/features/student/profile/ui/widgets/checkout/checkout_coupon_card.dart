import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';

/// Coupon code input card with an apply button and applied-code indicator.
class CheckoutCouponCard extends StatelessWidget {
  const CheckoutCouponCard({
    super.key,
    required this.controller,
    required this.appliedCode,
    required this.onApply,
  });

  final TextEditingController controller;
  final String? appliedCode;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: const Color(0xFF073F38),
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.checkoutCouponCode,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 11,
                      color: const Color(0xFF9AA8A3),
                    ),
                    prefixIcon: const Icon(
                      Icons.local_offer_outlined,
                      size: 18,
                      color: Color(0xFF71827E),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF9FBFA),
                    border: _border(),
                    enabledBorder: _border(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: onApply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text(
                    l10n.checkoutApply,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (appliedCode != null) ...[
            const SizedBox(height: 9),
            Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  size: 14,
                  color: Color(0xFF0F8A6F),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    appliedCode!,
                    style: GoogleFonts.inter(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF08785F),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Color(0xFFE1E9E6)),
    );
  }
}
