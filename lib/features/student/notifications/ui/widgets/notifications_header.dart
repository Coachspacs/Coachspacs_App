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
      padding: const EdgeInsets.fromLTRB(40, 24, 40, 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Color(0xFFE8EFFF),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onBack,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 38,
                color: AppColors.textBody,
              ),
            ),
          ),

          const SizedBox(width: 6),

          Expanded(
            child: Text(
              'Notifications',
              style: GoogleFonts.inter(
                color: AppColors.textBody,
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 64),
        ],
      ),
    );
  }
}
