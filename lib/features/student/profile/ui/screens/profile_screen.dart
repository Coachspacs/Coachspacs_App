import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';

import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_state.dart';

import '../widgets/profile/profile_logout_button.dart';
import '../widgets/profile/profile_menu_item.dart';
import '../widgets/profile/profile_section.dart';
import '../widgets/profile/profile_user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static Future<void> _showLogoutDialog(BuildContext context) async {
    final l10n = context.l10n;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(l10n.profileSignOut),
          content: Text(l10n.profileSignOutConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.commonCancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                l10n.profileSignOut,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    // AuthCubit clears the persisted session and emits AuthUnauthenticated,
    // which the app root listens to and routes back to login.
    await getIt<AuthCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    if (GuestSession.isGuest) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;

        LoginRequiredDialog.show(context).then((_) {
          if (!context.mounted) return;

          Navigator.pushReplacementNamed(
            context,
            AppRoutes.home,
          );
        });
      });

      return const Scaffold(
        backgroundColor: AppColors.bgDefault,
        body: SizedBox.shrink(),
      );
    }

    return BlocProvider<ProfileCubit>(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final profile = switch (state) {
              ProfileLoadSuccess(:final profile) => profile,
              ProfileSaveSuccess(:final profile) => profile,
              ProfileAvatarSuccess(:final profile) => profile,
              _ => null,
            };

            final name =
            profile?.fullName?.trim().isNotEmpty == true
                ? profile!.fullName!.trim()
                : l10n.profileStudent;

            final role = profile?.role == UserRole.instructor
                ? l10n.profileInstructor
                : l10n.profileStudent;

            final avatar = profile?.avatar ?? '';

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                28,
                16,
                24,
              ),
              child: Column(
                children: [
                  if (state is ProfileLoading ||
                      state is ProfileInitial)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: LinearProgressIndicator(
                        color: AppColors.primary,
                        backgroundColor: Color(0xFFE3EBE9),
                      ),
                    )
                  else if (state is ProfileLoadFailure)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        l10n.profileLoadFailed,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFB3261E),
                        ),
                      ),
                    ),

                  ProfileUserCard(
                    name: name,
                    role: role,
                    avatar: avatar,
                  ),

                  const SizedBox(height: 20),

                  ProfileSection(
                    children: [
                      // =================================================
                      // ACCOUNT SETTINGS
                      // =================================================

                      ProfileMenuItem(
                        icon: Icons.settings_outlined,
                        title: l10n.profileAccountSettings,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.accountSettings,
                        ),
                      ),



                      // =================================================
                      // ORDER HISTORY
                      // =================================================

                      ProfileMenuItem(
                        icon: Icons.receipt_long_outlined,
                        title: l10n.profileOrderHistory,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.orderHistory,
                        ),
                      ),

                      // =================================================
                      // MY CART
                      // =================================================

                      ProfileMenuItem(
                        icon: Icons.shopping_cart_outlined,
                        title: l10n.profileMyCart,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.cart,
                        ),
                      ),

                      // =================================================
                      // CERTIFICATES
                      // =================================================

                      ProfileMenuItem(
                        icon: Icons.workspace_premium_outlined,
                        title: l10n.profileCertificates,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.certificates,
                        ),
                      ),

                      // =================================================
                      // CONTACT US
                      // =================================================

                      ProfileMenuItem(
                        icon: Icons.support_agent_outlined,
                        title: l10n.profileContactUs,
                        showDivider: false,
                        onTap: () {
                          // TODO: ContactUs screen removed - re-implement when available
                          // Navigator.pushNamed(
                          //   context,
                          //   AppRoutes.contactUs,
                          // );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  ProfileLogoutButton(
                    onPressed: () =>
                        ProfileScreen._showLogoutDialog(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: const BottomNavBarWidget(
        navType: NavType.student,
        currentIndex: 3,
      ),
    );
  }
}