import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_path_milestone_item.dart';

class MyPathMilestones extends StatelessWidget {
  const MyPathMilestones({super.key});

  static const Color primary = Color(0xFF075E4D);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'CURRICULUM MILESTONES',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF71817E),
                letterSpacing: 0.4,
              ),
            ),
            const Spacer(),
            Text(
              '4 Modules',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: primary,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(
            14,
            14,
            14,
            10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(
              color: const Color(0xFFE1EAE7),
            ),
          ),
          child: const Column(
            children: [
              MyPathMilestoneItem(
                number: 1,
                title: 'Foundations & Setup',
                description:
                'Core concepts, workspace setup & initial diagnostic review.',
                isActive: true,
                actionLabel: 'Start here',
              ),

              MyPathMilestoneItem(
                number: 2,
                title: 'Core Skill Mastery',
                description:
                'Interactive code sessions, live practice exercises & quizzes.',
              ),

              MyPathMilestoneItem(
                number: 3,
                title: 'Capstone Portfolio Project',
                description:
                'Build a production-ready application reviewed by mentors.',
              ),

              MyPathMilestoneItem(
                number: 4,
                title: 'Verified Certificate',
                description:
                'Industry-recognized certification shared to LinkedIn & resume.',
                isLast: true,
                isFinalGoal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}