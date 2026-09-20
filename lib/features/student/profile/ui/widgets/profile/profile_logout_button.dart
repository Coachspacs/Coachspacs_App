import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.logout_rounded,
          size: 16,
          color: Color(0xFFE53935),
        ),
        label: Text(
          context.l10n.profileSignOut,
          style: GoogleFonts.inter(

            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFE53935),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFFFF9F9),
          side: const BorderSide(
            color: Color(0xFFF5CACA),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}