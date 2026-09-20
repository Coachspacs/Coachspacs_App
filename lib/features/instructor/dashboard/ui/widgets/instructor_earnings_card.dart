import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorEarningsCard extends StatelessWidget {
  const InstructorEarningsCard({
    super.key,
    this.amount,
  });

  final String? amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0EAE7),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F5F0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.attach_money_rounded,
              size: 21,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Earnings',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF788681),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  _formatAmount(amount),
                  style: GoogleFonts.inter(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF073F38),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F7F1),
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Text(
              'Lifetime',
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF267A68),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatAmount(String? amount) {
    if (amount == null || amount.isEmpty) return '\$0';
    if (amount.startsWith('\$')) return amount;
    return '\$$amount';
  }
}