import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';

import 'order_status_badge.dart';

class OrderMobileCard extends StatelessWidget {
  const OrderMobileCard({
    super.key,
    required this.order,
    required this.isExpanded,
    required this.onTap,
  });

  final OrderDto order;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final date = DateFormat.yMMMd().format(order.createdAt);

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
                          '#${order.id}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF075E4D),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$date · ${l10n.orderHistoryItemsCount(order.items.length)}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF71827E),
                            fontSize: 9.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  OrderStatusBadge(
                    status: order.status,
                  ),

                  const SizedBox(width: 2),

                  Icon(
                    isExpanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    size: 19,
                    color: const Color(0xFF9AA7A3),
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
                    l10n.orderHistoryTotal,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF71827E),
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    _money(order.totalAmount),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF073F38),
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              if (isExpanded) ...[
                const SizedBox(height: 11),

                const Divider(
                  height: 1,
                  color: Color(0xFFE4ECE9),
                ),

                const SizedBox(height: 10),

                ...order.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.play_circle_outline_rounded,
                          size: 15,
                          color: Color(0xFF075E4D),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            item.course.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF073F38),
                              fontSize: 10.5,
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          _money(item.priceAtPurchase),
                          style: GoogleFonts.inter(
                            color: const Color(0xFF71827E),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

String _money(String value) {
  final amount = double.tryParse(value);
  if (amount == null) return value;
  return '\$${amount.toStringAsFixed(2)}';
}
