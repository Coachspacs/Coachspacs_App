import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';

/// Totals card for the order being placed.
class CheckoutOrderSummaryCard extends StatelessWidget {
  const CheckoutOrderSummaryCard({
    super.key,
    required this.cart,
  });

  final CartDto cart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final total = double.tryParse(cart.total) ?? 0;
    final value = '\$${total.toStringAsFixed(2)}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        children: [
          _SummaryRow(
            title: l10n.checkoutTotal,
            value: value,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  final String title;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: isTotal ? 13 : 10.5,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              color: isTotal
                  ? const Color(0xFF073F38)
                  : const Color(0xFF687772),
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 15 : 10.5,
            fontWeight: FontWeight.w700,
            color: isTotal
                ? AppColors.primary
                : const Color(0xFF073F38),
          ),
        ),
      ],
    );
  }
}
