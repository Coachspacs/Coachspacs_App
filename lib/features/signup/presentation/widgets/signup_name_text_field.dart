import 'package:coach_space/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

class SignupNameTextField extends StatelessWidget {
  final String name;
  const SignupNameTextField({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        color: AppColors.textLight,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
