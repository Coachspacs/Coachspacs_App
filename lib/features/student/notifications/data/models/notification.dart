import 'package:flutter/material.dart';

enum NotificationType {
  course,
  purchase,
  completion,
  certificate,
  update,
  reminder,
}

class AppNotification {
  const AppNotification({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.isRead = false,
  });

  final String title;
  final String message;
  final String time;
  final NotificationType type;
  final bool isRead;

  IconData get icon {
    switch (type) {
      case NotificationType.course:
        return Icons.celebration_outlined;

      case NotificationType.purchase:
        return Icons.shopping_cart_outlined;

      case NotificationType.completion:
        return Icons.check_circle_outline;

      case NotificationType.certificate:
        return Icons.workspace_premium_outlined;

      case NotificationType.update:
        return Icons.info_outline_rounded;

      case NotificationType.reminder:
        return Icons.alarm_outlined;
    }
  }

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      title: title,
      message: message,
      time: time,
      type: type,
      isRead: isRead ?? this.isRead,
    );
  }
}
