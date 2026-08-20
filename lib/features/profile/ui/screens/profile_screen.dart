import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
<<<<<<< HEAD
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_action_tile.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_header.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_image_picker.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_info.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_logout_button.dart';
=======
import 'package:coach_space/features/profile/ui/widgets/profile/profile_logout_button.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_menu_item.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_section.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_top_bar.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_user_card.dart';
>>>>>>> 86e4d8e (Add order history and certificates screens)

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

<<<<<<< HEAD
  void _openEditProfile(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.editProfile);
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _handleLogout(BuildContext context) {
    // Server-side token revocation is best-effort; local tokens are always
    // cleared so the session ends even if the request fails. Navigation to the
    // login screen is handled by the app-level auth gate on
    // [AuthUnauthenticated].
    context.read<AuthCubit>().logout();
=======
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
>>>>>>> 86e4d8e (Add order history and certificates screens)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
<<<<<<< HEAD
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    ProfileHeader(onBack: () => Navigator.pop(context)),
=======
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
>>>>>>> 86e4d8e (Add order history and certificates screens)

                  const SizedBox(height: 16),

                  const ProfileUserCard(
                    name: 'Hadeel Baroud',
                    role: 'Student',
                    specialization: 'Data Science & AI',
                  ),

                  const SizedBox(height: 24),

                  // Learning
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

<<<<<<< HEAD
                    ProfileActionTile(
                      icon: Icons.lock_outline,
                      title: 'Account Security',
                      subtitle: 'Manage your password and security',
                      onTap: () {
                        _showMessage(context, 'Account Security');
                      },
                    ),
=======
                  const SizedBox(height: 24),
>>>>>>> 86e4d8e (Add order history and certificates screens)

                  // Account
                  ProfileSection(
                    title: 'Account',
                    children: [

<<<<<<< HEAD
                    ProfileActionTile(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        _showMessage(context, 'Settings');
                      },
                    ),
=======
>>>>>>> 86e4d8e (Add order history and certificates screens)

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

<<<<<<< HEAD
                    ProfileLogoutButton(
                      onPressed: () => _handleLogout(context),
                    ),
=======
                      ProfileMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Account Settings',
                        onTap: () {},
                        showDivider: false,
                      ),
                    ],
                  ),
>>>>>>> 86e4d8e (Add order history and certificates screens)

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
    );
  }
}
