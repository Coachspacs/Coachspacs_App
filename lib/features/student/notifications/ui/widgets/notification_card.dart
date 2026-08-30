import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import '../../data/models/notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isRead
                ? AppColors.white
                : const Color(0xFFF9FFFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: notification.isRead
                  ? AppColors.border
                  : const Color(0xFFD5EAE3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =================================================
              // ICON
              // =================================================

              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _iconBackground(
                    notification.type,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  notification.icon,
                  size: 22,
                  color: _iconColor(
                    notification.type,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // =================================================
              // CONTENT
              // =================================================

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: GoogleFonts.inter(
                              color: AppColors.textBody,
                              fontSize: 13,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),

                        if (!notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            margin:
                            const EdgeInsets.only(
                              top: 4,
                              left: 6,
                            ),
                            decoration:
                            const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      notification.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: AppColors.textLight,
                        fontSize: 10.5,
                        height: 1.45,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      notification.time,
                      style: GoogleFonts.inter(
                        color: AppColors.textLight,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _iconBackground(NotificationType type) {
    switch (type) {
      case NotificationType.course:
        return const Color(0xFFE5F4EF);

      case NotificationType.purchase:
        return const Color(0xFFEAF7F2);

      case NotificationType.completion:
        return const Color(0xFFE8F5F1);

      case NotificationType.certificate:
        return const Color(0xFFE8F0FA);

      case NotificationType.update:
        return const Color(0xFFEAF3F1);

      case NotificationType.reminder:
        return const Color(0xFFF4ECE6);
    }
  }

  Color _iconColor(NotificationType type) {
    switch (type) {
      case NotificationType.course:
      case NotificationType.purchase:
      case NotificationType.completion:
      case NotificationType.update:
        return AppColors.primary;

      case NotificationType.certificate:
        return const Color(0xFF5870B5);

      case NotificationType.reminder:
        return const Color(0xFF8A451B);
    }
  }
}









