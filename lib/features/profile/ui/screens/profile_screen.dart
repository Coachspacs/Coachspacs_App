import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_action_tile.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_header.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_image_picker.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_info.dart';
import 'package:coach_space/features/profile/ui/widgets/profile_logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
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

                    const SizedBox(height: 28),

                    const ProfileImagePicker(),

                    const SizedBox(height: 16),

                    const ProfileInfo(
                      name: 'Jane Doe',
                      email: 'jane@example.com',
                    ),

                    const SizedBox(height: 32),

                    ProfileActionTile(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      subtitle: 'Update your personal information',
                      onTap: () => _openEditProfile(context),
                    ),

                    const SizedBox(height: 12),

                    ProfileActionTile(
                      icon: Icons.lock_outline,
                      title: 'Account Security',
                      subtitle: 'Manage your password and security',
                      onTap: () {
                        _showMessage(context, 'Account Security');
                      },
                    ),

                    const SizedBox(height: 12),

                    ProfileActionTile(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        _showMessage(context, 'Settings');
                      },
                    ),

                    const SizedBox(height: 28),

                    ProfileLogoutButton(
                      onPressed: () => _handleLogout(context),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
