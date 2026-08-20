import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/order_history/order_mobile_card.dart';
import 'package:coach_space/features/profile/ui/widgets/order_history/order_pagination.dart';
import 'package:coach_space/features/profile/ui/widgets/order_history/order_search_bar.dart';
import 'package:coach_space/features/profile/ui/widgets/order_history/order_table.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() =>
      _OrderHistoryScreenState();
}

class _OrderHistoryScreenState
    extends State<OrderHistoryScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  static const int _itemsPerPage = 3;

  final List<OrderTableData> _orders = const [
    OrderTableData(
      orderNumber: '#CS-7721',
      date: 'Oct 12, 2023',
      items: '2 items',
      total: 89.99,
      status: 'Completed',
    ),
    OrderTableData(
      orderNumber: '#CS-7650',
      date: 'Sep 28, 2023',
      items: '1 item',
      total: 129.00,
      status: 'Completed',
    ),
    OrderTableData(
      orderNumber: '#CS-7512',
      date: 'Aug 05, 2023',
      items: '1 item',
      total: 15.00,
      status: 'Cancelled',
    ),
    OrderTableData(
      orderNumber: '#CS-7488',
      date: 'Jul 21, 2023',
      items: '3 items',
      total: 149.99,
      status: 'Completed',
    ),
    OrderTableData(
      orderNumber: '#CS-7391',
      date: 'Jul 04, 2023',
      items: '1 item',
      total: 59.99,
      status: 'Completed',
    ),
    OrderTableData(
      orderNumber: '#CS-7284',
      date: 'Jun 18, 2023',
      items: '2 items',
      total: 79.99,
      status: 'Completed',
    ),
    OrderTableData(
      orderNumber: '#CS-7190',
      date: 'Jun 02, 2023',
      items: '1 item',
      total: 39.99,
      status: 'Cancelled',
    ),
    OrderTableData(
      orderNumber: '#CS-7042',
      date: 'May 19, 2023',
      items: '2 items',
      total: 99.99,
      status: 'Completed',
    ),
    OrderTableData(
      orderNumber: '#CS-6955',
      date: 'May 03, 2023',
      items: '1 item',
      total: 49.99,
      status: 'Completed',
    ),
    OrderTableData(
      orderNumber: '#CS-6842',
      date: 'Apr 16, 2023',
      items: '2 items',
      total: 119.99,
      status: 'Completed',
    ),
    OrderTableData(
      orderNumber: '#CS-6731',
      date: 'Apr 02, 2023',
      items: '1 item',
      total: 29.99,
      status: 'Cancelled',
    ),
    OrderTableData(
      orderNumber: '#CS-6618',
      date: 'Mar 17, 2023',
      items: '1 item',
      total: 69.99,
      status: 'Completed',
    ),
  ];

  int _currentPage = 1;

  List<OrderTableData> get _filteredOrders {
    final query =
    _searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return _orders;
    }

    return _orders.where((order) {
      return order.orderNumber
          .toLowerCase()
          .contains(query) ||
          order.status.toLowerCase().contains(query);
    }).toList();
  }

  int get _totalPages {
    if (_filteredOrders.isEmpty) {
      return 1;
    }

    return (_filteredOrders.length / _itemsPerPage).ceil();
  }

  List<OrderTableData> get _currentOrders {
    final start = (_currentPage - 1) * _itemsPerPage;

    if (start >= _filteredOrders.length) {
      return [];
    }

    final end = (start + _itemsPerPage)
        .clamp(0, _filteredOrders.length);

    return _filteredOrders.sublist(start, end);
  }

  int get _startIndex {
    if (_filteredOrders.isEmpty) {
      return 0;
    }

    return ((_currentPage - 1) * _itemsPerPage) + 1;
  }

  int get _endIndex {
    final end = _currentPage * _itemsPerPage;

    if (end > _filteredOrders.length) {
      return _filteredOrders.length;
    }

    return end;
  }

  void _changePage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      _currentPage = 1;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                    'Order History',
                    style: TextStyle(
                      color: AppColors.textBody,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'View and manage your past purchases, '
                        'download receipts, and access enrolled '
                        'courses from previous transactions.',
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 20),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile =
                          constraints.maxWidth < 650;

                      return OrderSearchBar(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        onExport: () {},
                        isMobile: isMobile,
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile =
                          constraints.maxWidth < 650;

                      if (_currentOrders.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Text(
                              'No orders found.',
                              style: TextStyle(
                                color: AppColors.textLight,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      }

                      if (isMobile) {
                        return Column(
                          children: _currentOrders.map(
                                (order) {
                              return Padding(
                                padding:
                                const EdgeInsets.only(
                                  bottom: 10,
                                ),
                                child: OrderMobileCard(
                                  orderNumber:
                                  order.orderNumber,
                                  date: order.date,
                                  items: order.items,
                                  total: order.total,
                                  status: order.status,
                                  onTap: () {},
                                ),
                              );
                            },
                          ).toList(),
                        );
                      }

                      return OrderTable(
                        orders: _currentOrders,
                        onOrderPressed: (order) {},
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  OrderPagination(
                    currentPage: _currentPage,
                    totalPages: _totalPages,
                    startIndex: _startIndex,
                    endIndex: _endIndex,
                    totalOrders: _filteredOrders.length,
                    onPageChanged: _changePage,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}