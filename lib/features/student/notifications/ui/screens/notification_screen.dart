import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import '../../logic/notification_service.dart';
import '../widgets/notification_card.dart';
import '../widgets/notifications_header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final service = NotificationService.instance;

    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: ValueListenableBuilder<List>(
          valueListenable: service.notifications,
          builder: (context, notifications, _) {
            final today = notifications
                .where(
                  (notification) =>
              notification.time != 'Yesterday',
            )
                .toList();

            final earlier = notifications
                .where(
                  (notification) =>
              notification.time == 'Yesterday',
            )
                .toList();

            return Column(
              children: [
                // =================================================
                // HEADER
                // =================================================

                NotificationsHeader(
                  hasUnread: service.unreadCount > 0,
                  onBack: () {
                    Navigator.pop(context);
                  },
                  onMarkAllRead: () {
                    service.markAllAsRead();
                  },
                ),

                // =================================================
                // CONTENT
                // =================================================

                Expanded(
                  child: notifications.isEmpty
                      ? _EmptyNotifications()
                      : SingleChildScrollView(
                    padding:
                    const EdgeInsets.fromLTRB(
                      16,
                      20,
                      16,
                      30,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints:
                        const BoxConstraints(
                          maxWidth: 700,
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            if (today.isNotEmpty) ...[
                              _SectionTitle(
                                title: 'Today',
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              ...today.map(
                                    (notification) {
                                  final index =
                                  notifications
                                      .indexOf(
                                    notification,
                                  );

                                  return Padding(
                                    padding:
                                    const EdgeInsets
                                        .only(
                                      bottom: 10,
                                    ),
                                    child:
                                    NotificationCard(
                                      notification:
                                      notification,
                                      onTap: () {
                                        service
                                            .markAsRead(
                                          index,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],

                            if (earlier.isNotEmpty) ...[
                              const SizedBox(
                                height: 12,
                              ),

                              _SectionTitle(
                                title: 'Earlier',
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              ...earlier.map(
                                    (notification) {
                                  final index =
                                  notifications
                                      .indexOf(
                                    notification,
                                  );

                                  return Padding(
                                    padding:
                                    const EdgeInsets
                                        .only(
                                      bottom: 10,
                                    ),
                                    child:
                                    NotificationCard(
                                      notification:
                                      notification,
                                      onTap: () {
                                        service
                                            .markAsRead(
                                          index,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// =====================================================
// SECTION TITLE
// =====================================================

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: AppColors.textBody,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// =====================================================
// EMPTY STATE
// =====================================================

class _EmptyNotifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              'No notifications yet',
              style: GoogleFonts.inter(
                color: AppColors.textBody,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'We will let you know when something important happens.',
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
    );
  }
}

