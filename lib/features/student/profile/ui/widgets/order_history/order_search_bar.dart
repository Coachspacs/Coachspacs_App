import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final searchField = TextField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.inter(
        fontSize: 11,
        color: AppColors.textBody,
      ),
      decoration: InputDecoration(
        hintText: 'Search orders...',
        hintStyle: GoogleFonts.inter(
          color: AppColors.textLight,
          fontSize: 11,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          size: 19,
          color: Color(0xFF6D7E79),
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFDCE8E4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFDCE8E4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
    );

    if (isMobile) {
      return searchField;
    }

    return Row(
      children: [
        Expanded(
          child: searchField,
        ),

        const SizedBox(width: 10),

        SizedBox(
          height: 46,
          child: OutlinedButton.icon(
            onPressed: onExport,
            icon: const Icon(
              Icons.download_outlined,
              size: 16,
            ),
            label: Text(
              'Export',
              style: GoogleFonts.inter(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              backgroundColor: AppColors.white,
              side: const BorderSide(
                color: Color(0xFFDCE8E4),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}