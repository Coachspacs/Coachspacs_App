import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/notifications/data/models/notification_dto.dart';
import 'package:coach_space/features/student/notifications/logic/cubit/notifications_cubit.dart';

import '../widgets/notification_card.dart';
import '../widgets/notifications_header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationsCubit>()..load(),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  // ================================================================
  // MARK ALL AS READ
  // ================================================================

  Future<void> _markAllRead(BuildContext context) async {
    final success = await context.read<NotificationsCubit>().markAllRead();
    if (!context.mounted || success) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(context.l10n.notificationsMarkReadFailed)),
      );
  }

  // ================================================================
  // BUILD
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            final notifications = state is NotificationsSuccess
                ? state.notifications
                : const <NotificationDto>[];

            return Column(
              children: [
                // ==================================================
                // HEADER
                // ==================================================
                NotificationsHeader(
                  hasUnread: notifications.any((item) => !item.isRead),
                  onBack: () {
                    Navigator.pop(context);
                  },
                  onMarkAllRead: () => _markAllRead(context),
                ),

                // ==================================================
                // CONTENT
                // ==================================================
                Expanded(child: _buildContent(context, state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, NotificationsState state) {
    if (state is NotificationsInitial || state is NotificationsLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state is NotificationsFailure) {
      return _buildFailure(context, state);
    }

    if (state is NotificationsEmpty) {
      return _buildEmpty(context);
    }

    final notifications = state is NotificationsSuccess
        ? state.notifications
        : const <NotificationDto>[];

    if (notifications.isEmpty) {
      return _buildEmpty(context);
    }

    return _buildNotifications(context, notifications);
  }

  // ================================================================
  // LIST
  // ================================================================

  Widget _buildNotifications(
    BuildContext context,
    List<NotificationDto> notifications,
  ) {
    final now = DateTime.now();
    final today = notifications
        .where((item) => DateUtils.isSameDay(item.createdAt, now))
        .toList();
    final earlier = notifications
        .where((item) => !DateUtils.isSameDay(item.createdAt, now))
        .toList();

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<NotificationsCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          // ==================================================
          // TODAY
          // ==================================================
          if (today.isNotEmpty) ...[
            _SectionLabel(context.l10n.notificationsToday),
            const SizedBox(height: 10),
            ...today.map(
              (notification) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildCard(context, notification),
              ),
            ),
          ],

          // ==================================================
          // EARLIER
          // ==================================================
          if (earlier.isNotEmpty) ...[
            if (today.isNotEmpty) const SizedBox(height: 14),
            _SectionLabel(context.l10n.notificationsEarlier),
            const SizedBox(height: 10),
            ...earlier.map(
              (notification) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildCard(context, notification),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, NotificationDto notification) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: NotificationCard(
          notification: notification,
          onTap: () {
            if (!notification.isRead) {
              context.read<NotificationsCubit>().markRead(notification.id);
            }
          },
        ),
      ),
    );
  }

  // ================================================================
  // EMPTY
  // ================================================================

  Widget _buildEmpty(BuildContext context) {
    final l10n = context.l10n;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<NotificationsCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 68,
                  height: 68,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4F5EF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    size: 32,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  l10n.notificationsEmpty,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textBody,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  l10n.notificationsEmptyHint,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: AppColors.textLight,
                    fontSize: 10.5,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // FAILURE
  // ================================================================

  Widget _buildFailure(BuildContext context, NotificationsFailure state) {
    final l10n = context.l10n;
    final detail = _failureDetail(context, state.kind);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => context.read<NotificationsCubit>().load(),
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
            l10n.notificationsLoadFailed,
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
                onPressed: () => context.read<NotificationsCubit>().load(),
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

// =====================================================
// SECTION LABEL
// =====================================================

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: .5,
          color: const Color(0xFF8B9EB7),
        ),
      ),
    );
  }
}

// =====================================================
// HELPERS
// =====================================================

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
