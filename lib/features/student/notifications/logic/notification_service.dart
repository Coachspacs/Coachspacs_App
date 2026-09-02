import 'package:flutter/foundation.dart';


import '../data/models/notification.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
  NotificationService._();

  final ValueNotifier<List<AppNotification>> notifications =
  ValueNotifier<List<AppNotification>>(
    const [
      AppNotification(
        title: 'New Course',
        message:
        'A new course has been added: React & Next.js',
        time: '2 min ago',
        type: NotificationType.course,
      ),

      AppNotification(
        title: 'Purchase Successful',
        message:
        'Your course purchase was completed successfully.',
        time: '1 hour ago',
        type: NotificationType.purchase,
        isRead: true,
      ),

      AppNotification(
        title: 'Certificate Earned',
        message:
        'Congratulations! Your certificate is ready.',
        time: 'Yesterday',
        type: NotificationType.certificate,
        isRead: true,
      ),
    ],
  );

  void addNotification({
    required String title,
    required String message,
    required String time,
    required NotificationType type,
  }) {
    final current = notifications.value;

    notifications.value = [
      AppNotification(
        title: title,
        message: message,
        time: time,
        type: type,
      ),
      ...current,
    ];
  }

  void markAsRead(int index) {
    final current = [...notifications.value];

    if (index < 0 || index >= current.length) {
      return;
    }

    current[index] = current[index].copyWith(
      isRead: true,
    );

    notifications.value = current;
  }

  void markAllAsRead() {
    notifications.value = notifications.value
        .map(
          (notification) =>
          notification.copyWith(isRead: true),
    )
        .toList();
  }

  int get unreadCount {
    return notifications.value
        .where((notification) => !notification.isRead)
        .length;
  }
}