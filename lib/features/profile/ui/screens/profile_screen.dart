import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_logout_button.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_menu_item.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_section.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_top_bar.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text(
            'Are you sure you want to sign out?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                      (route) => false,
                );
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
                  const ProfileTopBar(
                    onNotificationPressed: null,
                  ),

                  const SizedBox(height: 16),

                  const ProfileUserCard(
                    name: 'Hadeel Baroud',
                    role: 'Student',
                    specialization: 'Data Science & AI',
                  ),

                  const SizedBox(height: 24),

                  ProfileSection(
                    title: 'Learning',
                    children: [
                      ProfileMenuItem(
                        icon: Icons.dashboard_outlined,
                        title: 'Dashboard',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.dashboard,
                          );
                        },
                      ),

                      ProfileMenuItem(
                        icon: Icons.menu_book_outlined,
                        title: 'Browse Courses',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.browseCourses,
                          );
                        },
                      ),

                      ProfileMenuItem(
                        icon: Icons.shopping_cart_outlined,
                        title: 'Cart',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.cart,
                          );
                        },
                      ),

                      ProfileMenuItem(
                        icon: Icons.history,
                        title: 'Order History',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.orderHistory,
                          );
                        },
                        showDivider: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  ProfileSection(
                    title: 'Account',
                    children: [
                      ProfileMenuItem(
                        icon: Icons.workspace_premium_outlined,
                        title: 'Certificates',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.certificates,
                          );
                        },
                      ),

                      ProfileMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Account Settings',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.accountSettings,
                          );
                        },
                        showDivider: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  ProfileLogoutButton(
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),

      // Profile = index 3
      bottomNavigationBar: const BottomNavBarWidget(
        currentIndex: 3,
      ),
    );
  }
}