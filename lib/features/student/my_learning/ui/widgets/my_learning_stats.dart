import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import '../../../profile/ui/widgets/dashboard/dashboard_stat_card.dart';

class MyLearningStats extends StatelessWidget {
  const MyLearningStats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardStatCard(
                title: 'ENROLLED',
                value: '3 courses',
                backgroundColor: AppColors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DashboardStatCard(
                title: 'CERTIFICATES',
                value: '1 earned',
                backgroundColor: AppColors.successLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const DashboardStatCard(
          title: 'HOURS STUDIED',
          value: '38.5 hrs',
          backgroundColor: Color(0xFFE8F8F7),
        ),
      ],
    );
  }
}