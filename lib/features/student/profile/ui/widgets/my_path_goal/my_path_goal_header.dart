import 'package:flutter/material.dart';

class MyPathGoalHeader extends StatelessWidget {
  const MyPathGoalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'What is your learning goal?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF10202F),
              height: 1.2,
            ),
          ),
        ),
        SizedBox(height: 7),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Choose the primary milestone that fits your personal journey right now.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              height: 1.55,
              color: Color(0xFF657774),
            ),
          ),
        ),
      ],
    );
  }
}