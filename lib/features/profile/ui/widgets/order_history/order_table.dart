import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/order_history/order_status_badge.dart';

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
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'ORDER #',
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'DATE',
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'ITEMS',
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'TOTAL',
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  child: Text(
                    'STATUS',
                    style: _headerStyle,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
          ),

          const Divider(
            height: 1,
            color: AppColors.border,
          ),

          ...orders.map(
                (order) {
              return InkWell(
                onTap: () {
                  onOrderPressed(order);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          order.orderNumber,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Text(
                          order.date,
                          style: const TextStyle(
                            color: AppColors.textLight,
                            fontSize: 11,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Text(
                          order.items,
                          style: const TextStyle(
                            color: AppColors.textLight,
                            fontSize: 11,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Text(
                          '\$${order.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: AppColors.textBody,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      Expanded(
                        child: OrderStatusBadge(
                          status: order.status,
                        ),
                      ),

                      const SizedBox(
                        width: 40,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 18,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
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

const TextStyle _headerStyle = TextStyle(
  color: AppColors.textLight,
  fontSize: 9,
  fontWeight: FontWeight.w600,
);