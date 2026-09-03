import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import 'package:coach_space/core/routing/routes.dart';

import '../widgets/dashboard/continue_learning_card.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/dashboard_stat_card.dart';
import '../widgets/dashboard/dashboard_top_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardTopBar(
                    onNotificationPressed: () {},
                    onProfilePressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const SizedBox(height: 24),
                  const DashboardHeader(
                    userName: 'Hadeel Baroud',
                  ),
                  const SizedBox(height: 20),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 500;

                      if (isMobile) {
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

                      return Row(
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: DashboardStatCard(
                              title: 'HOURS STUDIED',
                              value: '38.5 hrs',
                              backgroundColor: const Color(0xFFE8F8F7),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  ContinueLearningCard(
                    courseTitle: 'React 19 & Next.js App Router Masterclass',
                    lesson: 'Lesson 12: Advanced State Management',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.browseCourses,
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}