import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/formatters.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';

/// Card listing the courses being purchased.
class CheckoutItemsCard extends StatelessWidget {
  const CheckoutItemsCard({
    super.key,
    required this.cart,
  });

  final CartDto cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        children: [
          for (var index = 0; index < cart.items.length; index++) ...[
            if (index > 0) ...[
              const SizedBox(height: 10),
              const Divider(
                height: 1,
                color: Color(0xFFE4ECE9),
              ),
              const SizedBox(height: 10),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4F6F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.play_circle_outline_rounded,
                    size: 20,
                    color: Color(0xFF075E4D),
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Text(
                    cart.items[index].course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF073F38),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatMoney(cart.items[index].course.price),
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
