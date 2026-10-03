import 'package:flutter/material.dart';

import 'my_path_level_card.dart';

class MyPathLevelOptions extends StatefulWidget {
  const MyPathLevelOptions({super.key});

  @override
  State<MyPathLevelOptions> createState() => _MyPathLevelOptionsState();
}

class _MyPathLevelOptionsState extends State<MyPathLevelOptions> {
  int selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPathLevelCard(
          icon: Icons.menu_book_outlined,
          title: 'Beginner (From Scratch)',
          description:
          'Starting from the beginning with no prior knowledge',
          selected: selectedIndex == 0,
          onTap: () {
            setState(() {
              selectedIndex = 0;
            });
          },
        ),

        const SizedBox(height: 12),

        MyPathLevelCard(
          icon: Icons.code_rounded,
          title: 'Basic Knowledge',
          description:
          'Familiar with general concepts, need hands-on practice',
          selected: selectedIndex == 1,
          onTap: () {
            setState(() {
              selectedIndex = 1;
            });
          },
        ),

        const SizedBox(height: 12),

        MyPathLevelCard(
          icon: Icons.trending_up_rounded,
          title: 'Intermediate',
          description:
          'Practical experience, looking to build solid projects',
          selected: selectedIndex == 2,
          recommended: true,
          onTap: () {
            setState(() {
              selectedIndex = 2;
            });
          },
        ),

        const SizedBox(height: 12),

        MyPathLevelCard(
          icon: Icons.bookmark_rounded,
          title: 'Advanced',
          description:
          'Strong experience, looking to master complex topics',
          selected: selectedIndex == 3,
          skipText: 'Skips foundational intro modules',
          savesText: 'Saves ~18 hrs',
          onTap: () {
            setState(() {
              selectedIndex = 3;
            });
          },
        ),
      ],
    );
  }
}