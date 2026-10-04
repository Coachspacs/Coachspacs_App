import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_path_milestone_item.dart';
import 'my_path_palette.dart';

class MyPathMilestones extends StatelessWidget {
  const MyPathMilestones({super.key, required this.currentStep});

  /// 0-based wizard step the user is on; 4 means everything is done.
  final int currentStep;

  static const List<(String, String)> _steps = [
    (
      'Choose Your Goal',
      'Tell us what you are aiming for so we can tailor the journey.',
    ),
    (
      'Set Your Level',
      'We calibrate every module to your current experience.',
    ),
    (
      'Pick a Focus Skill',
      'Select the domain you want to master first.',
    ),
    (
      'Plan Your Schedule',
      'Choose weekly hours so the plan fits your life.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'YOUR PATH MILESTONES',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF71817E),
                letterSpacing: 0.4,
              ),
            ),
            const Spacer(),
            Text(
              '${currentStep.clamp(0, 4)}/4 Done',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: MyPathColors.primary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: const Border.fromBorderSide(
              BorderSide(color: Color(0xFFE1EAE7)),
            ),
          ),
          child: Column(
            children: [
              for (var i = 0; i < _steps.length; i++)
                MyPathMilestoneItem(
                  number: i + 1,
                  title: _steps[i].$1,
                  description: _steps[i].$2,
                  isDone: i < currentStep,
                  isActive: i == currentStep && currentStep < 4,
                  isLast: i == _steps.length - 1,
                  isFinalGoal: i == _steps.length - 1,
                  actionLabel: i == currentStep && currentStep < 4
                      ? 'Start here'
                      : null,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
