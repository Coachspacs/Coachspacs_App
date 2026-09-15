import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';

import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_state.dart';

import '../widgets/profile/profile_logout_button.dart';
import '../widgets/profile/profile_menu_item.dart';
import '../widgets/profile/profile_section.dart';
import '../widgets/profile/profile_user_card.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  // =========================================================
  // LOGOUT
  // =========================================================

  static void _showLogoutDialog(
      BuildContext context,
      ) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Sign Out',
          ),
          content: const Text(
            'Are you sure you want to sign out?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                GuestSession.logout();

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
    // =========================================================
    // GUEST
    // =========================================================

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

// =============================================================
// PROFILE VIEW
// =============================================================

class _ProfileView extends StatelessWidget {
  const _ProfileView();

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

            if (state is ProfileLoadSuccess) {
              final profile = state.profile;

              name = profile.fullName ?? 'Student';

              role = profile.role == UserRole.instructor
                  ? 'Instructor'
                  : 'Student';

              avatar = profile.avatar ?? '';
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                16,
                28,
                16,
                24,
              ),
              child: Column(
                children: [
                  // =================================================
                  // USER CARD
                  // =================================================

                  ProfileUserCard(
                    name: name,
                    role: role,
                    avatar: avatar,
                  ),

                  const SizedBox(height: 20),

                  // =================================================
                  // PROFILE MENU
                  // =================================================

                  ProfileSection(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Account Settings',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.accountSettings,
                          );
                        },
                      ),

                      ProfileMenuItem(
                        icon: Icons.history_rounded,
                        title: 'Order History',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.orderHistory,
                          );
                        },
                      ),

                      ProfileMenuItem(
                        icon: Icons.shopping_cart_outlined,
                        title: 'My Cart',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.cart,
                          );
                        },
                      ),

                      ProfileMenuItem(
                        icon:
                        Icons.workspace_premium_outlined,
                        title: 'Certificates',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.certificates,
                          );
                        },
                      ),

                      ProfileMenuItem(
                        icon: Icons.support_agent_outlined,
                        title: 'Contact us',
                        showDivider: false,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.contactUs,
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // =================================================
                  // SIGN OUT
                  // =================================================

                  ProfileLogoutButton(
                    onPressed: () {
                      ProfileScreen._showLogoutDialog(
                        context,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),

      // =========================================================
      // BOTTOM NAVIGATION
      // =========================================================

      bottomNavigationBar: const BottomNavBarWidget(
        navType: NavType.student,
        currentIndex: 3,
      ),
    );
  }
}