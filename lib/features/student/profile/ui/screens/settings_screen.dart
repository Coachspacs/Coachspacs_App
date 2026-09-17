import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';

import '../../logic/cubit/profile_cubit.dart';
import '../../logic/cubit/profile_state.dart';

import '../widgets/settings/account_settings_header.dart';
import '../widgets/settings/account_settings_option_card.dart';
import '../widgets/settings/account_settings_profile_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _AccountSettingsView(),
    );
  }
}

// =============================================================
// ACCOUNT SETTINGS VIEW
// =============================================================

class _AccountSettingsView extends StatelessWidget {
  const _AccountSettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            String name = 'Student';
            String role = 'Student';
            String avatar = '';

            // =====================================================
            // PROFILE DATA
            // =====================================================

            if (state is ProfileLoadSuccess) {
              final profile = state.profile;

              name = profile.fullName ?? 'Student';

              role = profile.role == UserRole.instructor
                  ? 'Instructor'
                  : 'Student';

              avatar = profile.avatar ?? '';
            }

            return Column(
              children: [
                // =================================================
                // HEADER
                // =================================================

                AccountSettingsHeader(
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),

                const Divider(
                  height: 1,
                  color: Color(0xFFE9EFED),
                ),

                // =================================================
                // CONTENT
                // =================================================

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      16,
                      20,
                      30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =========================================
                        // PROFILE CARD
                        // =========================================

                        AccountSettingsProfileCard(
                          name: name,
                          role: role,
                          avatar: avatar,
                        ),

                        const SizedBox(height: 20),

                        // =========================================
                        // DESCRIPTION
                        // =========================================

                        Text(
                          'Manage your account preferences, credentials, '
                              'and app customization below.',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            height: 1.5,
                            color: const Color(0xFF71839A),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // =========================================
                        // PROFILE INFORMATION
                        // =========================================

                        AccountSettingsOptionCard(
                          icon: Icons.person_outline_rounded,
                          title: 'Profile Information',
                          description:
                          'Edit name, avatar photo, email address, '
                              'number, and student bio headline',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.profileInformation,
                            );
                          },
                        ),

                        const SizedBox(height: 12),

                        // =========================================
                        // LEARNING & CERTIFICATES
                        // =========================================

                        AccountSettingsOptionCard(
                          icon: Icons.school_outlined,
                          title: 'Learning & Certificates',
                          description:
                          'Certificate recipient name, registered '
                              'degree, and career field',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.learningSettings,
                            );
                          },
                        ),

                        const SizedBox(height: 12),

                        // =========================================
                        // SECURITY
                        // =========================================

                        AccountSettingsOptionCard(
                          icon: Icons.lock_outline_rounded,
                          title: 'Security',
                          description:
                          'Password update, two-factor authentication, '
                              'and connected devices',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.securitySettings,
                            );
                          },
                        ),

                        const SizedBox(height: 12),

                        // =========================================
                        // PREFERENCES
                        // =========================================

                        AccountSettingsOptionCard(
                          icon: Icons.settings_outlined,
                          title: 'Preferences',
                          description:
                          'Course notifications, discount alerts, '
                              'and app language (English)',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.preferencesSettings,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}