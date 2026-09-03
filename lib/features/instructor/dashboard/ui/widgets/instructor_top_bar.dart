import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/app_routes.dart';

class InstructorTopBar extends StatelessWidget {
  const InstructorTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2EBE8),
          ),
        ),
      ),
      child: Row(
        children: [
          // =====================================================
          // LOGO
          // =====================================================

          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/Logo_img.png',
                fit: BoxFit.contain,
                errorBuilder: (
                    context,
                    error,
                    stackTrace,
                    ) {
                  return const Icon(
                    Icons.auto_awesome,
                    color: Color(0xFF075E4D),
                    size: 19,
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 9),

          // =====================================================
          // APP NAME
          // =====================================================

          Text(
            'Coach Space',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),

          const Spacer(),

          // =====================================================
          // NOTIFICATIONS
          // =====================================================

          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.instructorNotifications,
              );
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 38,
              minHeight: 38,
            ),
            splashRadius: 22,
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF263C38),
              size: 21,
            ),
          ),

          const SizedBox(width: 5),

          // =====================================================
          // PROFILE
          // =====================================================

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.instructorProfile,
              );
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                color: Color(0xFFDDF3EB),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'H',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}