import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class SignupNameTextField extends StatelessWidget {
  const SignupNameTextField({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        color: AppColors.primary,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}