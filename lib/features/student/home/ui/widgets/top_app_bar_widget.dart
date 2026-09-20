import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

import 'package:coach_space/core/helpers/protected_navigation.dart';

class TopAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const TopAppBarWidget({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

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
            context.l10n.appTitle,
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
        // NOTIFICATIONS
        // =================================================

        IconButton(
          onPressed: () {
            ProtectedNavigation.openNotifications(
              context,
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
        // PROFILE
        // =================================================

        GestureDetector(
          onTap: () {
            ProtectedNavigation.openProfile(
              context,
            );
          },
          child: Container(
            width: 34,
            height: 34,
            margin: const EdgeInsets.only(
              right: 16,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFE4F5F0),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'S',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),
        ),
      ],
    );
  }
}