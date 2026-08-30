import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({
    super.key,
    required this.onBack,
    required this.onMarkAllRead,
    required this.hasUnread,
  });

  final VoidCallback onBack;
  final VoidCallback onMarkAllRead;
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 24,
              color: AppColors.textBody,
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Text(
              'Notifications',
              style: GoogleFonts.inter(
                color: AppColors.textBody,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          if (hasUnread)
            TextButton(
              onPressed: onMarkAllRead,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                minimumSize: Size.zero,
                tapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Mark all as read',
                style: GoogleFonts.inter(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}


