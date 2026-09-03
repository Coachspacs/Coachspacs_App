import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';

class InstructorStudentsHeader extends StatelessWidget {
  const InstructorStudentsHeader({
    super.key,
    this.showProfile = true,
    this.onNotifications,
  });

  final bool showProfile;
  final VoidCallback? onNotifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // =====================================================
          // APP HEADER
          // =====================================================

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              10,
              16,
              10,
            ),
            child: Row(
              children: [
                // =================================================
                // LOGO
                // =================================================

                Image.asset(
                  'assets/images/Logo_img.png',
                  width: 34,
                  height: 34,
                  fit: BoxFit.contain,
                ),

                const SizedBox(width: 8),

                // =================================================
                // APP NAME
                // =================================================

                Text(
                  'Coach Space',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const Spacer(),

                // =================================================
                // NOTIFICATIONS
                // =================================================

                IconButton(
                  onPressed: onNotifications ??
                          () {
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
                    Icons.notifications_none_outlined,
                    size: 21,
                    color: Color(0xFF526762),
                  ),
                ),

                // =================================================
                // PROFILE
                // =================================================

                if (showProfile) ...[
                  const SizedBox(width: 4),

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
                        color: Color(0xFFDDF2EC),
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
              ],
            ),
          ),

          // =====================================================
          // DIVIDER
          // =====================================================

          Container(
            height: 1,
            color: const Color(0xFFE8EFED),
          ),
        ],
      ),
    );
  }
}