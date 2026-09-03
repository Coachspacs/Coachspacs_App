import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorNotificationsSummary extends StatelessWidget {
  const InstructorNotificationsSummary({
    super.key,
    required this.unreadCount,
  });

  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    if (unreadCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFD4E9E3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFD5EEE7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              size: 17,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              'You have $unreadCount unread '
                  '${unreadCount == 1 ? 'notification' : 'notifications'}.',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF27534B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}