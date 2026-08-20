import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.title,
    required this.instructor,
    required this.price,
    required this.onDelete,
  });

  final String title;
  final String instructor;
  final double price;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.bgDefault,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.code,
              color: AppColors.textLight,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textBody,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Instructor: $instructor',
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 10,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline,
              size: 20,
            ),
            color: AppColors.textLight,
          ),
        ],
      ),
    );
  }
}