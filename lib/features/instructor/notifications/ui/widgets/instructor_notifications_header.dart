import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorNotificationsHeader extends StatelessWidget {
  const InstructorNotificationsHeader({
    super.key,
    required this.unreadCount,
    required this.onMarkAllAsRead,
  });

  final int unreadCount;
  final VoidCallback onMarkAllAsRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        14,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // =================================================
              // BACK
              // =================================================

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 21,
                  color: Color(0xFF073F38),
                ),
              ),

              const SizedBox(width: 8),

              // =================================================
              // TITLE
              // =================================================

              Expanded(
                child: Text(
                  'Notifications',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),
              ),

              // =================================================
              // MARK ALL
              // =================================================

              if (unreadCount > 0)
                TextButton(
                  onPressed: onMarkAllAsRead,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Mark all as read',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF075E4D),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 12),

          // =================================================
          // DIVIDER
          // =================================================

          Container(
            height: 1,
            color: const Color(0xFFE8EFED),
          ),
        ],
      ),
    );
  }
}