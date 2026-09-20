import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/widgets/user_avatar.dart';

class InstructorTopBar extends StatelessWidget {
  const InstructorTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF7FAF9),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 16,

      title: Row(
        children: [
          // =================================================
          // COACH SPACE LOGO
          // =================================================

          SizedBox(
            width: 36,
            height: 36,
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
                  size: 20,
                );
              },
            ),
          ),

          const SizedBox(width: 4),

          // =================================================
          // APP NAME
          // =================================================

          Text(
            'Coach Space',
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),

          const Spacer(),
        ],
      ),

      actions: [
        // =================================================
        // INSTRUCTOR NOTIFICATIONS
        // =================================================

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
          icon: const Icon(
            Icons.notifications_none_outlined,
            color: Color(0xFF263C38),
            size: 21,
          ),
        ),

        const SizedBox(width: 4),

        // =================================================
        // INSTRUCTOR PROFILE
        // =================================================

        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.instructorProfile,
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: const UserAvatar(size: 34),
          ),
        ),
      ],
    );
  }
}