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
        borderRadius: BorderRadius.circular(14),

        child: Container(
          width: double.infinity,

          padding: const EdgeInsets.fromLTRB(
            14,
            15,
            14,
            15,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
            BorderRadius.circular(14),

            border: Border.all(
              color: const Color(0xFFE0E8EF),
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
                width: 38,
                height: 38,

                decoration: BoxDecoration(
                  color: _iconBackground(
                    notification.type,
                  ),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  notification.icon,
                  size: 18,
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
                    // =================================================
                    // TITLE + TIME + UNREAD
                    // =================================================

                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            maxLines: 2,
                            overflow:
                            TextOverflow.ellipsis,

                            style:
                            GoogleFonts.inter(
                              color:
                              AppColors.textBody,
                              fontSize: 13,
                              height: 1.3,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // TIME
                        Text(
                          notification.time,
                          style:
                          GoogleFonts.inter(
                            fontSize: 9,
                            color:
                            const Color(
                              0xFF91A0B5,
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        // UNREAD DOT
                        if (!notification.isRead)
                          Container(
                            margin:
                            const EdgeInsets.only(
                              top: 4,
                            ),
                            width: 7,
                            height: 7,
                            decoration:
                            const BoxDecoration(
                              color: Color(
                                0xFF13B78D,
                              ),
                              shape:
                              BoxShape.circle,
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
                      overflow:
                      TextOverflow.ellipsis,

                      style: GoogleFonts.inter(
                        color:
                        const Color(0xFF52606D),
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

  // =====================================================
  // ICON BACKGROUND
  // =====================================================

  Color _iconBackground(
      NotificationType type,
      ) {
    switch (type) {
      case NotificationType.course:
        return const Color(0xFFFFF3D9);

      case NotificationType.purchase:
        return const Color(0xFFE8F8F3);

      case NotificationType.completion:
        return const Color(0xFFE7F8F2);

      case NotificationType.certificate:
        return const Color(0xFFEAF2FF);

      case NotificationType.update:
        return const Color(0xFFE8F8F3);

      case NotificationType.reminder:
        return const Color(0xFFF5EBFF);
    }
  }

  // =====================================================
  // ICON COLOR
  // =====================================================

  Color _iconColor(
      NotificationType type,
      ) {
    switch (type) {
      case NotificationType.course:
        return const Color(0xFFF39A24);

      case NotificationType.purchase:
      case NotificationType.completion:
      case NotificationType.update:
        return AppColors.primary;

      case NotificationType.certificate:
        return const Color(0xFF5574C4);

      case NotificationType.reminder:
        return const Color(0xFF9B51E0);
    }
  }
}