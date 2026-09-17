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
        18,
        18,
        18,
        8,
      ),
      child: Row(
        children: [
          // =================================================
          // BACK ARROW
          // =================================================

          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 26,
              color: AppColors.textBody,
            ),
          ),

          const SizedBox(width: 12),

          // =================================================
          // TITLE
          // =================================================

          Text(
            'Notifications',
            style: GoogleFonts.inter(
              color: AppColors.textBody,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}