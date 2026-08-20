import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/order_history/order_status_badge.dart';

class OrderMobileCard extends StatelessWidget {
  const OrderMobileCard({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
    required this.onTap,
  });

  final String orderNumber;
  final String date;
  final String items;
  final double total;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  orderNumber,
                  style: const TextStyle(
                    color: AppColors.textBody,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                OrderStatusBadge(
                  status: status,
                ),
              ],
            ),

            const SizedBox(height: 7),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$date · $items',
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 9,
                  ),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.textBody,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}