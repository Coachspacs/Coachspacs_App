import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';

import '../../logic/cubit/profile_cubit.dart';
import '../../logic/cubit/profile_state.dart';

import '../widgets/settings/account_settings_header.dart';
import '../widgets/settings/account_settings_option_card.dart';
import '../widgets/settings/account_settings_profile_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _AccountSettingsView(),
    );
  }
}

class _AccountSettingsView extends StatelessWidget {
  const _AccountSettingsView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            String name = '';
            String role = l10n.profileStudent;
            String avatar = '';

            if (state is ProfileLoadSuccess) {
              final profile = state.profile;
              name = profile.fullName ?? '';
              role = profile.role == UserRole.instructor
                  ? l10n.profileInstructor
                  : l10n.profileStudent;
              avatar = profile.avatar ?? '';
            }

            return Column(
              children: [
                AccountSettingsHeader(
                  onBack: () => Navigator.pop(context),
                ),
                const Divider(height: 1, color: Color(0xFFE9EFED)),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AccountSettingsProfileCard(
                          name: name.isEmpty ? l10n.profileStudent : name,
                          role: role,
                          avatar: avatar,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          l10n.settingsManageDescription,
                          style: const TextStyle(
                            fontSize: 11,
                            height: 1.5,
                            color: Color(0xFF71839A),
                          ),
                        ),
                        const SizedBox(height: 18),
                        AccountSettingsOptionCard(
                          icon: Icons.person_outline_rounded,
                          title: l10n.settingsProfileInfoTitle,
                          description: l10n.settingsProfileInfoDescription,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.profileInformation,
                          ),
                        ),
                        const SizedBox(height: 12),
                        AccountSettingsOptionCard(
                          icon: Icons.school_outlined,
                          title: l10n.settingsLearningTitle,
                          description: l10n.settingsLearningDescription,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.learningSettings,
                          ),
                        ),
                        const SizedBox(height: 12),
                        AccountSettingsOptionCard(
                          icon: Icons.lock_outline_rounded,
                          title: l10n.settingsSecurityTitle,
                          description: l10n.settingsSecurityDescription,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.securitySettings,
                          ),
                        ),
                        const SizedBox(height: 12),
                        AccountSettingsOptionCard(
                          icon: Icons.settings_outlined,
                          title: l10n.settingsPreferencesTitle,
                          description: l10n.settingsPreferencesDescription,
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.preferencesSettings,
                          ),
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
