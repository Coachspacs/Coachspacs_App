import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupTermsRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color firstColor;
  final Color secondColor;
  final double fontSize;
  final VoidCallback? onTap;

  const SignupTermsRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.firstColor,
    required this.secondColor,
    required this.fontSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: TextStyle(color: firstColor, fontSize: fontSize),
          ),
          TextSpan(
            text: secondText,
            style: TextStyle(
              color: secondColor,
              fontSize: fontSize,
              fontWeight: onTap != null ? FontWeight.bold : null,
            ),
            recognizer: onTap != null
                ? (TapGestureRecognizer()..onTap = onTap)
                : null,
          ),
        ],
      ),
    );
  }
}
