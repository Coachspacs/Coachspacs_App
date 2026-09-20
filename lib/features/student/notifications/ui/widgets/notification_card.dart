import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/notifications/data/models/notification_dto.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final NotificationDto notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final (icon, iconBackground, iconColor) = _visualFor(notification.type);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),

        child: Container(
          width: double.infinity,

          padding: const EdgeInsets.fromLTRB(14, 15, 14, 15),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(14),

            border: Border.all(color: const Color(0xFFE0E8EF)),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // =================================================
              // ICON
              // =================================================
              Container(
                width: 38,
                height: 38,

                decoration: BoxDecoration(
                  color: iconBackground,
                  shape: BoxShape.circle,
                ),

                child: Icon(icon, size: 18, color: iconColor),
              ),

              const SizedBox(width: 12),

              // =================================================
              // CONTENT
              // =================================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // =================================================
                    // TITLE + TIME + UNREAD
                    // =================================================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            style: GoogleFonts.inter(
                              color: AppColors.textBody,
                              fontSize: 13,
                              height: 1.3,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // TIME
                        Text(
                          _timeLabel(notification.createdAt),
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            color: const Color(0xFF91A0B5),
                          ),
                        ),

                        const SizedBox(width: 5),

                        // UNREAD DOT
                        if (!notification.isRead)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: Color(0xFF13B78D),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // =================================================
                    // MESSAGE
                    // =================================================
                    Text(
                      notification.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,

                      style: GoogleFonts.inter(
                        color: const Color(0xFF52606D),
                        fontSize: 11,
                        height: 1.45,
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

  String _timeLabel(DateTime createdAt) {
    if (DateUtils.isSameDay(createdAt, DateTime.now())) {
      return DateFormat.jm().format(createdAt);
    }
    return DateFormat.yMMMd().format(createdAt);
  }

  // =====================================================
  // ICON / COLOR MAPPING
  // =====================================================

  (IconData, Color, Color) _visualFor(String type) {
    final value = type.toLowerCase();

    if (value.contains('cert')) {
      return (
        Icons.workspace_premium_outlined,
        const Color(0xFFEAF2FF),
        const Color(0xFF5574C4),
      );
    }

    if (value.contains('purchase') ||
        value.contains('payment') ||
        value.contains('order')) {
      return (
        Icons.shopping_cart_outlined,
        const Color(0xFFE8F8F3),
        AppColors.primary,
      );
    }

    if (value.contains('complet') || value.contains('success')) {
      return (
        Icons.check_circle_outline,
        const Color(0xFFE7F8F2),
        AppColors.primary,
      );
    }

    if (value.contains('remind') || value.contains('deadline')) {
      return (
        Icons.alarm_outlined,
        const Color(0xFFF5EBFF),
        const Color(0xFF9B51E0),
      );
    }

    if (value.contains('update') ||
        value.contains('announce') ||
        value.contains('info')) {
      return (
        Icons.info_outline_rounded,
        const Color(0xFFE8F8F3),
        AppColors.primary,
      );
    }

    if (value.contains('course')) {
      return (
        Icons.celebration_outlined,
        const Color(0xFFFFF3D9),
        const Color(0xFFF39A24),
      );
    }

    return (
      Icons.notifications_none_rounded,
      const Color(0xFFE4F5EF),
      AppColors.primary,
    );
  }
}
