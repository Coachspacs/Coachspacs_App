import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({
    super.key,
    required this.status,
  });

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final (label, background, foreground, dot) = switch (status) {
      OrderStatus.pending => (
          l10n.orderHistoryStatusPending,
          const Color(0xFFFFF3D6),
          const Color(0xFFB7791F),
          const Color(0xFFD69E2E),
        ),
      OrderStatus.paid => (
          l10n.orderHistoryStatusPaid,
          const Color(0xFFD2F6E5),
          const Color(0xFF08785F),
          const Color(0xFF0F8A6F),
        ),
      OrderStatus.failed => (
          l10n.orderHistoryStatusFailed,
          const Color(0xFFFFE5E5),
          const Color(0xFFD9363E),
          const Color(0xFFE5484D),
        ),
      OrderStatus.refunded => (
          l10n.orderHistoryStatusRefunded,
          const Color(0xFFE0E7FF),
          const Color(0xFF3B4CCA),
          const Color(0xFF4F63D2),
        ),
      OrderStatus.cancelled => (
          l10n.orderHistoryStatusCancelled,
          const Color(0xFFEDEDED),
          const Color(0xFF5F6B68),
          const Color(0xFF71827E),
        ),
      OrderStatus.unknown => (
          l10n.orderHistoryStatus,
          const Color(0xFFEDEDED),
          const Color(0xFF5F6B68),
          const Color(0xFF71827E),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: dot,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 5),

          Text(
            label,
            style: GoogleFonts.inter(
              color: foreground,
              fontSize: 8.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
