import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

/// Labeled password input with a visibility toggle.
///
/// Shared by the student and instructor security settings screens (and
/// reusable anywhere a password with show/hide affordance is needed).
class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.onToggle,
    this.fieldHeight = 46,
    this.borderRadius = 11,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggle;
  final double fieldHeight;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF073F38),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: fieldHeight,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF344842),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              suffixIcon: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 19,
                  color: const Color(0xFF71807C),
                ),
              ),
              border: _border(),
              enabledBorder: _border(),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Color(0xFFD5E1DE)),
    );
  }
}
