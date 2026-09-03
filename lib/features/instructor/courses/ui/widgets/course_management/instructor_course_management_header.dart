import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';

class InstructorCourseManagementHeader extends StatelessWidget {
  const InstructorCourseManagementHeader({
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
              color: Color(0xFF173D37),
            ),
          ),

          const SizedBox(width: 6),

          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(9),
            ),
            clipBehavior: Clip.antiAlias,
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
                  size: 18,
                );
              },
            ),
          ),

          const SizedBox(width: 8),

          Text(
            'Coach Space',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),

          const Spacer(),

          // Notifications
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.instructorNotifications,
              );
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 36,
              minHeight: 36,
            ),
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 21,
              color: Color(0xFF526762),
            ),
          ),

          const SizedBox(width: 4),

          // Profile
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.instructorProfile,
              );
            },
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Color(0xFFDDF3EB),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                'H',
                style: GoogleFonts.inter(
                  fontSize: 12,
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