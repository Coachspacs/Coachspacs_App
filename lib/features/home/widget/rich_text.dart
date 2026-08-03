import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color firstColor;
  final Color secondColor;
  final double fontSize;
  const MyRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.firstColor,
    required this.secondColor,
    required this.fontSize,
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
            style: TextStyle(color: secondColor, fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
