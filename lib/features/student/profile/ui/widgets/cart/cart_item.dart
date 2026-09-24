import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.onDelete,
  });

  final String title;
  final String price;
  final String image;
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

          ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: SizedBox(
              width: 82,
              height: 82,
              child: _buildImage(),
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

                const SizedBox(height: 7),

                Text(
                  price,
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

  Widget _buildImage() {
    if (image.isEmpty) return _buildPlaceholder();

    return Image.network(
      image,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFFE5F1EE),
      child: const Center(
        child: Icon(
          Icons.play_circle_outline_rounded,
          size: 30,
          color: Color(0xFF075E4D),
        ),
      ),
    );
  }
}
