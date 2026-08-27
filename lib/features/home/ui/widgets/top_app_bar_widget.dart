import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/app_routes.dart';

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
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 16,

      title: Row(
        children: [
          // =================================================
          // COACH SPACE LOGO
          // =================================================

          Container(
            width: 36,
            height: 36,
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
                    size: 20,
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 9),

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
        // NOTIFICATIONS
        // =================================================

        IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.notifications,
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

        Container(
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
      ],
    );
  }
}