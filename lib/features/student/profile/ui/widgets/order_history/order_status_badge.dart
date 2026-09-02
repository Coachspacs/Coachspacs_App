import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final bool isCancelled =
        status.toLowerCase() == 'cancelled';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: isCancelled
            ? const Color(0xFFFFE5E5)
            : const Color(0xFFD2F6E5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: isCancelled
                  ? const Color(0xFFE5484D)
                  : const Color(0xFF0F8A6F),
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 5),

          Text(
            status,
            style: GoogleFonts.inter(
              color: isCancelled
                  ? const Color(0xFFD9363E)
                  : const Color(0xFF08785F),
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}