import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
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

            const _OrderHistoryHeader(),

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

    final filters = <(OrderStatus?, String)>[
      (null, l10n.homeAll),
      (OrderStatus.pending, l10n.orderHistoryStatusPending),
      (OrderStatus.paid, l10n.orderHistoryStatusPaid),
      (OrderStatus.failed, l10n.orderHistoryStatusFailed),
      (OrderStatus.refunded, l10n.orderHistoryStatusRefunded),
      (OrderStatus.cancelled, l10n.orderHistoryStatusCancelled),
    ];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final (status, label) = filters[index];
          final isSelected = _statusFilter == status;

          return GestureDetector(
            onTap: () {
              setState(() {
                _statusFilter = status;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF075E4D) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF075E4D)
                      : const Color(0xFFD3DFDB),
                ),
              ),
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight:
                  isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF344540),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ================================================================
  // EMPTY
  // ================================================================

  Widget _buildEmptyState(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xFFE4F6F0),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 22,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            l10n.orderHistoryEmpty,
            style: GoogleFonts.inter(
              color: const Color(0xFF073F38),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            l10n.orderHistoryEmptyHint,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF71827E),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // FAILURE
  // ================================================================

  Widget _buildFailure(BuildContext context, OrderHistoryFailure state) {
    final l10n = context.l10n;
    final detail = _failureDetail(context, state.kind);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<OrderHistoryCubit>().refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 46,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 14),
          Text(
            l10n.orderHistoryLoadFailed,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          if (detail != null) ...[
            const SizedBox(height: 6),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11.5,
                color: const Color(0xFF71827E),
              ),
            ),
          ],
          const SizedBox(height: 18),
          Center(
            child: SizedBox(
              height: 42,
              child: ElevatedButton.icon(
                onPressed: () => context.read<OrderHistoryCubit>().load(),
                icon: const Icon(Icons.refresh_rounded, size: 17),
                label: Text(
                  l10n.commonRetry,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// HEADER
// ===================================================================

class _OrderHistoryHeader extends StatelessWidget {
  const _OrderHistoryHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        16,
        0,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 34,
              minHeight: 34,
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 23,
              color: Color(0xFF073F38),
            ),
          ),

          const SizedBox(width: 4),

          Text(
            context.l10n.orderHistoryTitle,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// HELPERS
// ===================================================================

String? _failureDetail(BuildContext context, FailureKind kind) {
  final l10n = context.l10n;
  return switch (kind) {
    FailureKind.offline => l10n.errorOffline,
    FailureKind.unauthorized => l10n.errorSessionExpired,
    FailureKind.forbidden => l10n.errorForbidden,
    FailureKind.notFound => l10n.errorNotFound,
    FailureKind.conflict => l10n.errorConflict,
    FailureKind.rateLimited => l10n.errorRateLimited,
    FailureKind.serverError => l10n.errorServer,
    _ => null,
  };
}
