import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({
    super.key,
    required this.subtotal,
    required this.onCheckout,
  });

  final double subtotal;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    const double taxes = 0;

    final total = subtotal + taxes;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // TITLE
          // =====================================================

          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFE4F6F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  size: 18,
                  color: Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 10),

              Text(
                'Order Summary',
                style: GoogleFonts.inter(
                  color: const Color(0xFF073F38),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // =====================================================
          // SUBTOTAL
          // =====================================================

          _SummaryRow(
            title: 'Subtotal',
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 10),

          // =====================================================
          // TAXES
          // =====================================================

          const _SummaryRow(
            title: 'Taxes',
            value: 'Calculated at checkout',
          ),

          const SizedBox(height: 16),

          const Divider(
            height: 1,
            color: Color(0xFFE4ECE9),
          ),

          const SizedBox(height: 16),

          // =====================================================
          // TOTAL
          // =====================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.inter(
                  color: const Color(0xFF40514D),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Text(
                '\$${total.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF075E4D),
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // =====================================================
          // CHECKOUT BUTTON
          // =====================================================

          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Checkout',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(width: 6),

                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: Text(
              '30-Day Money-Back Guarantee',
              style: GoogleFonts.inter(
                color: AppColors.textLight,
                fontSize: 8.5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// SUMMARY ROW
// ===============================================================

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: AppColors.textLight,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),

        const SizedBox(width: 12),

        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.inter(
              color: AppColors.textLight,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}