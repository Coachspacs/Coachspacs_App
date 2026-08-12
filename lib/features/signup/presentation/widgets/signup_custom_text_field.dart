import 'package:coach_space/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

class SignupCustomTextField extends StatelessWidget {
  final String hintText;
  final Color borderColor;
  final TextEditingController? controller;
  final bool obscureText;
  const SignupCustomTextField({
    super.key,
    required this.hintText,
    required this.borderColor,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
