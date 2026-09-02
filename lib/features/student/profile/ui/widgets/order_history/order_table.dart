import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import 'order_status_badge.dart';

class OrderTable extends StatelessWidget {
  const OrderTable({
    super.key,
    required this.orders,
    required this.onOrderPressed,
  });

  final List<OrderTableData> orders;
  final ValueChanged<OrderTableData> onOrderPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Column(
        children: [
          // =====================================================
          // HEADER
          // =====================================================

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: _TableHeader(
                    text: 'ORDER #',
                  ),
                ),
                const Expanded(
                  child: _TableHeader(
                    text: 'DATE',
                  ),
                ),
                const Expanded(
                  child: _TableHeader(
                    text: 'ITEMS',
                  ),
                ),
                const Expanded(
                  child: _TableHeader(
                    text: 'TOTAL',
                  ),
                ),
                const Expanded(
                  child: _TableHeader(
                    text: 'STATUS',
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
            color: Color(0xFFE4ECE9),
          ),

          // =====================================================
          // ROWS
          // =====================================================

          ...orders.map(
                (order) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    onOrderPressed(order);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            order.orderNumber,
                            style: GoogleFonts.inter(
                              color: AppColors.primary,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            order.date,
                            style: GoogleFonts.inter(
                              color: AppColors.textLight,
                              fontSize: 10,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            order.items,
                            style: GoogleFonts.inter(
                              color: AppColors.textLight,
                              fontSize: 10,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            '\$${order.total.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              color: AppColors.textBody,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: OrderStatusBadge(
                              status: order.status,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 30,
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 18,
                            color: Color(0xFF9AA7A3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// TABLE HEADER
// ===============================================================

class _TableHeader extends StatelessWidget {
  const _TableHeader({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: AppColors.textLight,
        fontSize: 8.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
  }
}

// ===============================================================
// ORDER DATA
// ===============================================================

class OrderTableData {
  const OrderTableData({
    required this.orderNumber,
    required this.date,
    required this.items,
    required this.total,
    required this.status,
  });

  final String orderNumber;
  final String date;
  final String items;
  final double total;
  final String status;
}