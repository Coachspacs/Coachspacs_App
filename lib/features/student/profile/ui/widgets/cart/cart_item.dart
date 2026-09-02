import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // COURSE IMAGE
          // =====================================================

          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F1EE),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Center(
              child: Icon(
                Icons.code_rounded,
                size: 34,
                color: Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // =====================================================
          // COURSE INFORMATION
          // =====================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF073F38),
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Instructor: $instructor',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF788681),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF075E4D),
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),

          // =====================================================
          // DELETE BUTTON
          // =====================================================

          IconButton(
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            icon: const Icon(
              Icons.delete_outline_rounded,
              size: 19,
              color: Color(0xFF40514D),
            ),
          ),
        ],
      ),
    );
  }
}