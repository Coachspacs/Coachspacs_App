import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum InstructorNotificationType {
  success,
  student,
  warning,
  payment,
  general,
}

class InstructorNotificationData {
  const InstructorNotificationData({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.type,
    required this.isRead,
  });

  final String title;
  final String message;
  final String time;
  final IconData icon;
  final InstructorNotificationType type;
  final bool isRead;

  InstructorNotificationData copyWith({
    bool? isRead,
  }) {
    return InstructorNotificationData(
      title: title,
      message: message,
      time: time,
      icon: icon,
      type: type,
      isRead: isRead ?? this.isRead,
    );
  }
}

class InstructorNotificationCard extends StatelessWidget {
  const InstructorNotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });

  final InstructorNotificationData notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final Color accentColor =
    _getAccentColor(notification.type);

    return Dismissible(
      key: ValueKey(
        '${notification.title}-${notification.time}',
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: 20,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE95D5D),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: notification.isRead
                  ? Colors.white
                  : const Color(0xFFF1F8F5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: notification.isRead
                    ? const Color(0xFFDDE8E5)
                    : const Color(0xFFCDE4DD),
              ),
            ),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // =================================================
                // ICON
                // =================================================

                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: Icon(
                    notification.icon,
                    size: 20,
                    color: accentColor,
                  ),
                ),

                const SizedBox(width: 11),

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
                                fontSize: 11,
                                fontWeight:
                                notification.isRead
                                    ? FontWeight.w600
                                    : FontWeight.w700,
                                color:
                                const Color(0xFF173D37),
                              ),
                            ),
                          ),

                          if (!notification.isRead)
                            Container(
                              width: 7,
                              height: 7,
                              margin:
                              const EdgeInsets.only(
                                top: 4,
                                left: 6,
                              ),
                              decoration:
                              const BoxDecoration(
                                color: Color(0xFF075E4D),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Text(
                        notification.message,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          height: 1.45,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF687873),
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        notification.time,
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF9AA7A3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getAccentColor(
      InstructorNotificationType type,
      ) {
    switch (type) {
      case InstructorNotificationType.success:
        return const Color(0xFF16805E);

      case InstructorNotificationType.student:
        return const Color(0xFF3478A8);

      case InstructorNotificationType.warning:
        return const Color(0xFFD08A27);

      case InstructorNotificationType.payment:
        return const Color(0xFF7656A6);

      case InstructorNotificationType.general:
        return const Color(0xFF075E4D);
    }
  }
}