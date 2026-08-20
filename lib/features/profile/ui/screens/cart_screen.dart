import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/cart/cart_item.dart';
import 'package:coach_space/features/profile/ui/widgets/cart/cart_summary.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<_CartItemData> _items = [
    const _CartItemData(
      title: 'Next.js 15 And React 19 fullstack...',
      instructor: 'Dr. Tariq Al-Mansoor',
      price: 89.00,
    ),
  ];

  double get _subtotal {
    return _items.fold(
      0,
          (total, item) => total + item.price,
    );
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'My Cart',
                    style: TextStyle(
                      color: AppColors.textBody,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '${_items.length} ${_items.length == 1 ? 'item' : 'items'}',
                    style: const TextStyle(
                      color: AppColors.textLight,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 20),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 650;

                      if (isMobile) {
                        return Column(
                          children: [
                            _buildItems(),

                            const SizedBox(height: 16),

                            CartSummary(
                              subtotal: _subtotal,
                              onCheckout: () {},
                            ),
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildItems(),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            flex: 2,
                            child: CartSummary(
                              subtotal: _subtotal,
                              onCheckout: () {},
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItems() {
    return Column(
      children: List.generate(
        _items.length,
            (index) {
          final item = _items[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CartItem(
              title: item.title,
              instructor: item.instructor,
              price: item.price,
              onDelete: () {
                _removeItem(index);
              },
            ),
          );
        },
      ),
    );
  }
}

class _CartItemData {
  const _CartItemData({
    required this.title,
    required this.instructor,
    required this.price,
  });

  final String title;
  final String instructor;
  final double price;
}