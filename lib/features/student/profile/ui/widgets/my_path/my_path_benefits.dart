import 'package:flutter/material.dart';

import 'my_path_benefit_card.dart';

class MyPathBenefits extends StatelessWidget {
  const MyPathBenefits({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyPathBenefitCard(
          icon: Icons.tune_rounded,
          title: 'Tailored to Your Goals',
          description:
          'Calibrated directly to your skill level, weekly time availability, and chosen career ambitions.',
        ),
        SizedBox(height: 10),
        MyPathBenefitCard(
          icon: Icons.work_outline_rounded,
          title: 'Built on Verified Curricula',
          description:
          'Hands-on projects and accredited certificates authored and updated with premier tech leaders.',
        ),
        SizedBox(height: 10),
        MyPathBenefitCard(
          icon: Icons.trending_up_rounded,
          title: 'Adaptive & Always Current',
          description:
          'Dynamic milestones that recalibrate on-the-fly whenever your speed or priorities fluctuate.',
        ),
      ],
    );
  }
}