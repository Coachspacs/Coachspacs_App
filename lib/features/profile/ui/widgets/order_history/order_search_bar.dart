import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class OrderSearchBar extends StatelessWidget {
  const OrderSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onExport,
    required this.isMobile,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onExport;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search orders...',
          hintStyle: const TextStyle(
            color: AppColors.textLight,
            fontSize: 12,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: AppColors.textLight,
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.border,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.border,
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Search orders...',
              hintStyle: const TextStyle(
                color: AppColors.textLight,
                fontSize: 12,
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 20,
                color: AppColors.textLight,
              ),
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.border,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.border,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        SizedBox(
          height: 44,
          child: OutlinedButton.icon(
            onPressed: onExport,
            icon: const Icon(
              Icons.download_outlined,
              size: 16,
            ),
            label: const Text(
              'Export',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textBody,
              backgroundColor: AppColors.white,
              side: const BorderSide(
                color: AppColors.border,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}