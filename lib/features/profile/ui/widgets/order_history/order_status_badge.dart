import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final bool isCancelled = status == 'Cancelled';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: isCancelled
            ? const Color(0xFFFFE1E1)
            : AppColors.successLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isCancelled
              ? Colors.red
              : AppColors.primary,
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}