import 'package:flutter/material.dart';

import 'my_path_goal_card.dart';

class MyPathGoalOptions extends StatefulWidget {
  const MyPathGoalOptions({super.key});

  @override
  State<MyPathGoalOptions> createState() => _MyPathGoalOptionsState();
}

class _MyPathGoalOptionsState extends State<MyPathGoalOptions> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPathGoalCard(
          icon: Icons.business_center_outlined,
          title: 'Get a new job / career change',
          description:
          'Transition into high-demand roles with personalized roadmaps',
          badge: 'Popular',
          selected: selectedIndex == 0,
          onTap: () {
            setState(() {
              selectedIndex = 0;
            });
          },
        ),
        const SizedBox(height: 14),
        MyPathGoalCard(
          icon: Icons.trending_up_rounded,
          title: 'Improve my current skills',
          description:
          'Deepen domain expertise and master contemporary frameworks',
          selected: selectedIndex == 1,
          recommendedText: 'Recommended: ~6 wks path',
          activeText: 'Active Selection',
          onTap: () {
            setState(() {
              selectedIndex = 1;
            });
          },
        ),
        const SizedBox(height: 14),
        MyPathGoalCard(
          icon: Icons.school_outlined,
          title: 'Prepare for an exam',
          description:
          'Structured mock tests, speed-quizzes, and accredited certifications',
          selected: selectedIndex == 2,
          onTap: () {
            setState(() {
              selectedIndex = 2;
            });
          },
        ),
        const SizedBox(height: 14),
        MyPathGoalCard(
          icon: Icons.auto_awesome_outlined,
          title: 'Learn for personal growth',
          description:
          'Explore creative passions and intellectually stimulating topics',
          selected: selectedIndex == 3,
          onTap: () {
            setState(() {
              selectedIndex = 3;
            });
          },
        ),
        const SizedBox(height: 14),
        MyPathGoalCard(
          icon: Icons.more_horiz_rounded,
          title: 'Other / Custom Journey',
          description:
          'Customized pace or unique cross-disciplinary objectives',
          selected: selectedIndex == 4,
          onTap: () {
            setState(() {
              selectedIndex = 4;
            });
          },
        ),
      ],
    );
  }
}