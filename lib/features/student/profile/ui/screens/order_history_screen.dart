import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/back_title_header.dart';
import 'package:coach_space/core/widgets/empty_state_card.dart';
import 'package:coach_space/core/widgets/error_retry_view.dart';
import 'package:coach_space/core/widgets/selectable_chip_row.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';
import 'package:coach_space/features/student/profile/logic/cubit/order_history_cubit.dart';

import '../widgets/order_history/order_mobile_card.dart';
import '../widgets/order_history/order_search_bar.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OrderHistoryCubit>()..load(),
      child: const _OrderHistoryView(),
    );
  }
}

class _OrderHistoryView extends StatefulWidget {
  const _OrderHistoryView();

  @override
  State<_OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<_OrderHistoryView> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';
  OrderStatus? _statusFilter;
  int? _expandedOrderId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ================================================================
  // FILTERS
  // ================================================================

  List<OrderDto> _applyFilters(List<OrderDto> orders) {
    return orders.where((order) {
      final matchesQuery = _query.isEmpty ||
          order.id.toString().contains(_query);

      final matchesStatus =
          _statusFilter == null || order.status == _statusFilter;

      return matchesQuery && matchesStatus;
    }).toList();
  }

  // ================================================================
  // BUILD
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Column(
          children: [
            // ==================================================
            // HEADER
            // ==================================================

            BackTitleHeader(title: context.l10n.orderHistoryTitle),

            // ==================================================
            // CONTENT
            // ==================================================

            Expanded(
              child: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
                builder: (context, state) {
                  if (state is OrderHistoryInitial ||
                      state is OrderHistoryLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF075E4D),
                      ),
                    );
                  }

                  if (state is OrderHistoryFailure) {
                    return _buildFailure(context, state);
                  }

                  final orders = state is OrderHistorySuccess
                      ? state.orders
                      : const <OrderDto>[];
                  final hasMore =
                      state is OrderHistorySuccess && state.hasMore;

                  return _buildOrders(context, orders, hasMore);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrders(
    BuildContext context,
    List<OrderDto> orders,
    bool hasMore,
  ) {
    final filtered = _applyFilters(orders);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<OrderHistoryCubit>().refresh(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (hasMore && notification.metrics.extentAfter < 240) {
            context.read<OrderHistoryCubit>().loadMore();
          }
          return false;
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 30),
          children: [
            OrderSearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _query = value.trim().toLowerCase();
                });
              },
            ),

            const SizedBox(height: 12),

            _buildStatusFilters(context),

            const SizedBox(height: 14),

            if (orders.isEmpty || filtered.isEmpty)
              _buildEmptyState(context)
            else
              ...filtered.map(
                (order) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: OrderMobileCard(
                    order: order,
                    isExpanded: _expandedOrderId == order.id,
                    onTap: () {
                      setState(() {
                        _expandedOrderId =
                            _expandedOrderId == order.id ? null : order.id;
                      });
                    },
                  ),
                ),
              ),

            if (hasMore && filtered.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 8, bottom: 4),
                child: Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF075E4D),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // STATUS FILTERS
  // ================================================================

  Widget _buildStatusFilters(BuildContext context) {
    final l10n = context.l10n;

    return SelectableChipRow<OrderStatus?>(
      items: [
        SelectableChipItem(value: null, label: l10n.homeAll),
        SelectableChipItem(
          value: OrderStatus.pending,
          label: l10n.orderHistoryStatusPending,
        ),
        SelectableChipItem(
          value: OrderStatus.paid,
          label: l10n.orderHistoryStatusPaid,
        ),
        SelectableChipItem(
          value: OrderStatus.failed,
          label: l10n.orderHistoryStatusFailed,
        ),
        SelectableChipItem(
          value: OrderStatus.refunded,
          label: l10n.orderHistoryStatusRefunded,
        ),
        SelectableChipItem(
          value: OrderStatus.cancelled,
          label: l10n.orderHistoryStatusCancelled,
        ),
      ],
      selectedValue: _statusFilter,
      onSelected: (status) => setState(() => _statusFilter = status),
    );
  }

  // ================================================================
  // EMPTY
  // ================================================================

  Widget _buildEmptyState(BuildContext context) {
    final l10n = context.l10n;

    return EmptyStateCard(
      icon: Icons.receipt_long_outlined,
      title: l10n.orderHistoryEmpty,
      hint: l10n.orderHistoryEmptyHint,
      titleFontSize: 13,
      hintFontSize: 10,
    );
  }

  // ================================================================
  // FAILURE
  // ================================================================

  Widget _buildFailure(BuildContext context, OrderHistoryFailure state) {
    final l10n = context.l10n;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<OrderHistoryCubit>().refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
        children: [
          ErrorRetryView(
            title: l10n.orderHistoryLoadFailed,
            detail: failureDetail(context, state.kind),
            onRetry: () => context.read<OrderHistoryCubit>().load(),
          ),
        ],
      ),
    );
  }
}
