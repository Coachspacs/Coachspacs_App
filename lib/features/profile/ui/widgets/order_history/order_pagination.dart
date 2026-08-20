import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class OrderPagination extends StatelessWidget {
  const OrderPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.startIndex,
    required this.endIndex,
    required this.totalOrders,
    required this.onPageChanged,
  });

  final int currentPage;
  final int totalPages;
  final int startIndex;
  final int endIndex;
  final int totalOrders;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing $startIndex-$endIndex of $totalOrders orders',
          style: const TextStyle(
            color: AppColors.textLight,
            fontSize: 10,
          ),
        ),

        Row(
          children: [
            _PageButton(
              icon: Icons.chevron_left,
              enabled: currentPage > 1,
              onPressed: () {
                onPageChanged(currentPage - 1);
              },
            ),

            const SizedBox(width: 5),

            for (int page = 1; page <= totalPages; page++) ...[
              _PageNumberButton(
                page: page,
                isSelected: page == currentPage,
                onPressed: () {
                  onPageChanged(page);
                },
              ),

              if (page != totalPages)
                const SizedBox(width: 5),
            ],

            const SizedBox(width: 5),

            _PageButton(
              icon: Icons.chevron_right,
              enabled: currentPage < totalPages,
              onPressed: () {
                onPageChanged(currentPage + 1);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.white,
          side: const BorderSide(
            color: AppColors.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Icon(
          icon,
          size: 17,
          color: enabled
              ? AppColors.textBody
              : AppColors.textLight,
        ),
      ),
    );
  }
}

class _PageNumberButton extends StatelessWidget {
  const _PageNumberButton({
    required this.page,
    required this.isSelected,
    required this.onPressed,
  });

  final int page;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: isSelected
              ? AppColors.primary
              : AppColors.white,
          foregroundColor: isSelected
              ? AppColors.white
              : AppColors.textBody,
          side: BorderSide(
            color: isSelected
                ? AppColors.primary
                : AppColors.border,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          '$page',
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}