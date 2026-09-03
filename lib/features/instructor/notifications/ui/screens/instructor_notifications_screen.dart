import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import 'package:coach_space/features/instructor/notifications/ui/widgets/instructor_notification_card.dart';
import 'package:coach_space/features/instructor/notifications/ui/widgets/instructor_notifications_header.dart';
import 'package:coach_space/features/instructor/notifications/ui/widgets/instructor_notifications_summary.dart';

class InstructorNotificationsScreen extends StatefulWidget {
  const InstructorNotificationsScreen({
    super.key,
  });

  @override
  State<InstructorNotificationsScreen> createState() =>
      _InstructorNotificationsScreenState();
}

class _InstructorNotificationsScreenState
    extends State<InstructorNotificationsScreen> {
  // =====================================================
  // NOTIFICATIONS
  // =====================================================

  final List<InstructorNotificationData> _notifications = [
    const InstructorNotificationData(
      title: 'Course Approved',
      message:
      'Your course "React 19 & Next.js App Router Masterclass" has been approved and published.',
      time: '10 min ago',
      icon: Icons.check_circle_outline_rounded,
      type: InstructorNotificationType.success,
      isRead: false,
    ),

    const InstructorNotificationData(
      title: 'New Student Enrolled',
      message:
      'Ahmad Hassan has enrolled in your Flutter Architecture course.',
      time: '2 hours ago',
      icon: Icons.person_add_alt_1_rounded,
      type: InstructorNotificationType.student,
      isRead: false,
    ),

    const InstructorNotificationData(
      title: 'Course Needs Changes',
      message:
      'Your UI/UX Design System Guide course needs some changes before it can be published.',
      time: 'Yesterday',
      icon: Icons.info_outline_rounded,
      type: InstructorNotificationType.warning,
      isRead: false,
    ),

    const InstructorNotificationData(
      title: 'Payment Received',
      message:
      'You received \$245.00 from your recent course sales.',
      time: '2 days ago',
      icon: Icons.account_balance_wallet_outlined,
      type: InstructorNotificationType.payment,
      isRead: true,
    ),

    const InstructorNotificationData(
      title: 'Welcome to Coach Space',
      message:
      'Your instructor account is ready. Start creating and sharing your courses.',
      time: '3 days ago',
      icon: Icons.celebration_outlined,
      type: InstructorNotificationType.general,
      isRead: true,
    ),
  ];

  // =====================================================
  // UNREAD COUNT
  // =====================================================

  int get _unreadCount {
    return _notifications
        .where(
          (notification) => !notification.isRead,
    )
        .length;
  }

  // =====================================================
  // MARK ALL AS READ
  // =====================================================

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        _notifications[i] =
            _notifications[i].copyWith(
              isRead: true,
            );
      }
    });
  }

  // =====================================================
  // MARK AS READ
  // =====================================================

  void _markAsRead(int index) {
    if (_notifications[index].isRead) {
      return;
    }

    setState(() {
      _notifications[index] =
          _notifications[index].copyWith(
            isRead: true,
          );
    });
  }

  // =====================================================
  // DELETE
  // =====================================================

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================

            InstructorNotificationsHeader(
              unreadCount: _unreadCount,
              onMarkAllAsRead: _markAllAsRead,
            ),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child: _notifications.isEmpty
                  ? const _EmptyNotificationsState()
                  : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  24,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // SUMMARY
                    // =================================================

                    InstructorNotificationsSummary(
                      unreadCount: _unreadCount,
                    ),

                    if (_unreadCount > 0)
                      const SizedBox(height: 14),

                    // =================================================
                    // NOTIFICATIONS
                    // =================================================

                    ...List.generate(
                      _notifications.length,
                          (index) {
                        return Padding(
                          padding:
                          const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child:
                          InstructorNotificationCard(
                            notification:
                            _notifications[index],
                            onTap: () {
                              _markAsRead(index);
                            },
                            onDelete: () {
                              _deleteNotification(
                                index,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================
// EMPTY STATE
// =============================================================

class _EmptyNotificationsState
    extends StatelessWidget {
  const _EmptyNotificationsState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F2EF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 38,
                color: Color(0xFF6F8881),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'No notifications',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF263C38),
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'You are all caught up. New notifications will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                height: 1.5,
                color: Color(0xFF899792),
              ),
            ),
          ],
        ),
      ),
    );
  }
}