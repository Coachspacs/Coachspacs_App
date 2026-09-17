import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import '../../logic/notification_service.dart';
import '../widgets/notification_card.dart';
import '../widgets/notifications_header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service =
        NotificationService.instance;

    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: ValueListenableBuilder<List>(
          valueListenable:
          service.notifications,

          builder:
              (context, notifications, _) {
            final todayNotifications =
            notifications.take(3).toList();

            final earlierNotifications =
            notifications.skip(3).toList();

            return Column(
              children: [
                // =================================================
                // HEADER
                // =================================================

                NotificationsHeader(
                  hasUnread:
                  service.unreadCount > 0,

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
                      ? const _EmptyNotifications()
                      : SingleChildScrollView(
                    physics:
                    const BouncingScrollPhysics(),

                    padding:
                    const EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      30,
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        // =================================================
                        // TODAY
                        // =================================================

                        const _SectionLabel(
                          'TODAY',
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        ...todayNotifications
                            .map(
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

                        // =================================================
                        // EARLIER
                        // =================================================

                        if (earlierNotifications
                            .isNotEmpty) ...[
                          const SizedBox(
                            height: 14,
                          ),

                          const _SectionLabel(
                            'EARLIER',
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          ...earlierNotifications
                              .map(
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
              ],
            );
          },
        ),
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
      padding: const EdgeInsets.only(
        left: 4,
      ),
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
// EMPTY STATE
// =====================================================

class _EmptyNotifications
    extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [
            Container(
              width: 68,
              height: 68,

              decoration:
              const BoxDecoration(
                color: Color(0xFFE4F5EF),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons
                    .notifications_none_rounded,
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
                fontWeight:
                FontWeight.w700,
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