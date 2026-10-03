import 'package:flutter/material.dart';

class MyPathLevelHeader extends StatelessWidget {
  const MyPathLevelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'What is your current level in this field?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            height: 1.2,
            color: Color(0xFF10202F),
          ),
        ),
        SizedBox(height: 7),
        Text(
          'Select your level so we can customize your learning path '
              'and skip what you already know.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            height: 1.55,
            color: Color(0xFF657774),
          ),
        ),
      ],
    );
  }
}