import 'package:flutter/material.dart';

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
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              color: AppColors.textBody,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          _SummaryRow(
            title: 'Subtotal',
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 8),

          const _SummaryRow(
            title: 'Taxes',
            value: 'Calculated at checkout',
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              color: AppColors.border,
            ),
          ),

          _SummaryRow(
            title: 'Total',
            value: '\$${total.toStringAsFixed(2)}',
            isTotal: true,
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Checkout →',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Center(
            child: Text(
              '30-Day Money-Back Guarantee',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 8,
              ),
            ),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textLight,
            fontSize: isTotal ? 13 : 10,
            fontWeight: isTotal
                ? FontWeight.w700
                : FontWeight.w400,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: isTotal
                  ? AppColors.textBody
                  : AppColors.textLight,
              fontSize: isTotal ? 20 : 10,
              fontWeight: isTotal
                  ? FontWeight.w700
                  : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}