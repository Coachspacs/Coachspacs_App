import 'package:coachspacs/core/theming/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldName extends StatelessWidget {
  final String name;
  const TextFieldName({super.key, required this.name});

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
