import 'package:flutter/material.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';

import 'my_path_hours_card.dart';

class MyPathHoursOptions extends StatefulWidget {
  const MyPathHoursOptions({super.key});

  @override
  State<MyPathHoursOptions> createState() => _MyPathHoursOptionsState();
}

class _MyPathHoursOptionsState extends State<MyPathHoursOptions> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        MyPathHoursCard(
          icon: Icons.coffee_outlined,
          title: l10n.myPathHoursOneTwoTitle,
          description: l10n.myPathHoursOneTwoDescription,
          selected: selectedIndex == 0,
          onTap: () {
            setState(() {
              selectedIndex = 0;
            });
          },
        ),

        const SizedBox(height: 12),

        MyPathHoursCard(
          icon: Icons.tune_rounded,
          title: l10n.myPathHoursThreeFiveTitle,
          description: l10n.myPathHoursThreeFiveDescription,
          badge: l10n.commonRecommended,
          selected: selectedIndex == 1,
          onTap: () {
            setState(() {
              selectedIndex = 1;
            });
          },
        ),

        const SizedBox(height: 12),

        MyPathHoursCard(
          icon: Icons.trending_up_rounded,
          title: l10n.myPathHoursSixTenTitle,
          description: l10n.myPathHoursSixTenDescription,
          selected: selectedIndex == 2,
          onTap: () {
            setState(() {
              selectedIndex = 2;
            });
          },
        ),

        const SizedBox(height: 12),

        MyPathHoursCard(
          icon: Icons.local_fire_department_outlined,
          title: l10n.myPathHoursMoreThanTenTitle,
          description: l10n.myPathHoursMoreThanTenDescription,
          selected: selectedIndex == 3,
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