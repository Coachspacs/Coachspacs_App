import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/helpers/protected_navigation.dart';
import 'package:coach_space/core/widgets/user_avatar.dart';

class CourseDetailsTopBar extends StatelessWidget {
  const CourseDetailsTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2EBE8)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: const Icon(
              Icons.arrow_back,
              size: 21,
              color: Color(0xFF263C38),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            context.l10n.courseDetailsTitle,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => ProtectedNavigation.openProfile(context),
            child: const UserAvatar(size: 36),
          ),
        ],
      ),
    );
  }
}
