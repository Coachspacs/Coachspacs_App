import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class SignupTermsRichText extends StatelessWidget {
  const SignupTermsRichText({
    super.key,
    required this.agreed,
    required this.onChanged,
  });

  final bool agreed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!agreed);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: Checkbox(
              value: agreed,
              activeColor: AppColors.primary,
              side: const BorderSide(
                color: AppColors.borderColor,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              onChanged: (value) {
                onChanged(value ?? false);
              },
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text.rich(
                TextSpan(
                  text: 'I agree to the ',
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 13,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}