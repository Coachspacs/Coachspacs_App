import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

/// Filled input used across the checkout form.
class CheckoutTextField extends StatelessWidget {
  const CheckoutTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.keyboardType,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.inter(
        fontSize: 11,
        color: const Color(0xFF073F38),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 10.5,
          color: const Color(0xFF9AA8A3),
        ),
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
                size: 18,
                color: const Color(0xFF71827E),
              ),
        filled: true,
        fillColor: const Color(0xFFF9FBFA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Color(0xFFE1E9E6)),
    );
  }
}
