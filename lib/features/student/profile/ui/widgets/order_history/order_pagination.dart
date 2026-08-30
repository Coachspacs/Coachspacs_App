import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      children: [
        Expanded(
          child: Text(
            'Showing $startIndex-$endIndex of $totalOrders orders',
            style: GoogleFonts.inter(
              color: AppColors.textLight,
              fontSize: 9,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PageButton(
              icon: Icons.chevron_left_rounded,
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
              icon: Icons.chevron_right_rounded,
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
            color: Color(0xFFDCE8E4),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Icon(
          icon,
          size: 17,
          color: enabled
              ? const Color(0xFF073F38)
              : const Color(0xFFB7C2BF),
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
                : const Color(0xFFDCE8E4),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        child: Text(
          '$page',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}