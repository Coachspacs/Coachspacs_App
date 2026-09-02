import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import 'order_status_badge.dart';

class OrderMobileCard extends StatelessWidget {
  const OrderMobileCard({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
    required this.onTap,
  });

  final String orderNumber;
  final String date;
  final String items;
  final double total;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFDCE8E4),
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order icon
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5F4EF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.receipt_long_outlined,
                      size: 19,
                      color: Color(0xFF075E4D),
                    ),
                  ),

                  const SizedBox(width: 11),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderNumber,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF075E4D),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$date · $items',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF71827E),
                            fontSize: 9.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  OrderStatusBadge(
                    status: status,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Divider(
                height: 1,
                color: Color(0xFFE4ECE9),
              ),

              const SizedBox(height: 11),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Total',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF71827E),
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF073F38),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}