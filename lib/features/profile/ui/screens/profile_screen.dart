import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';

import 'package:coach_space/features/profile/ui/widgets/profile/profile_logout_button.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_menu_item.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_section.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_top_bar.dart';
import 'package:coach_space/features/profile/ui/widgets/profile/profile_user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  // =====================================================
  // LOGOUT DIALOG
  // =====================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            'Sign Out',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF687772),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF075E4D),
                ),
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
              child: Text(
                'Sign Out',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // PROTECTED NAVIGATION
  // =====================================================

  void _openProtectedRoute(
      BuildContext context,
      String route,
      ) {
    if (GuestSession.isGuest) {
      LoginRequiredDialog.show(context);
      return;
    }

    Navigator.pushNamed(
      context,
      route,
    );
  }

  @override
  Widget build(BuildContext context) {
    // =====================================================
    // GUEST PROTECTION
    // =====================================================

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

    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      // =====================================================
      // BODY
      // =====================================================

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // TOP BAR
            // =================================================

            ProfileTopBar(
              onNotificationPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.notifications,
                );
              },
            ),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        // =====================================
                        // PROFILE
                        // =====================================

                        const ProfileUserCard(
                          name: 'Sondos Abu Skhail',
                          role: 'Student',
                          specialization:
                          'Information Technology',
                        ),

                        const SizedBox(height: 22),

                        // =====================================
                        // MY LEARNING
                        // =====================================

                        _sectionTitle('My Learning'),

                        const SizedBox(height: 10),

                        ProfileSection(
                          title: '',
                          children: [
                            ProfileMenuItem(
                              icon: Icons.search_rounded,
                              title: 'Browse Courses',
                              onTap: () {
                                _openProtectedRoute(
                                  context,
                                  AppRoutes.browseCourses,
                                );
                              },
                            ),

                            ProfileMenuItem(
                              icon:
                              Icons.shopping_cart_outlined,
                              title: 'My Cart',
                              onTap: () {
                                _openProtectedRoute(
                                  context,
                                  AppRoutes.cart,
                                );
                              },
                            ),

                            ProfileMenuItem(
                              icon: Icons.history_rounded,
                              title: 'Order History',
                              onTap: () {
                                _openProtectedRoute(
                                  context,
                                  AppRoutes.orderHistory,
                                );
                              },
                              showDivider: false,
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // =====================================
                        // ACCOUNT SETTINGS
                        // =====================================

                        _sectionTitle(
                          'Account Settings',
                        ),

                        const SizedBox(height: 10),

                        ProfileSection(
                          title: '',
                          children: [
                            ProfileMenuItem(
                              icon: Icons
                                  .workspace_premium_outlined,
                              title: 'Certificates',
                              onTap: () {
                                _openProtectedRoute(
                                  context,
                                  AppRoutes.certificates,
                                );
                              },
                            ),

                            ProfileMenuItem(
                              icon: Icons.settings_outlined,
                              title: 'Account Settings',
                              onTap: () {
                                _openProtectedRoute(
                                  context,
                                  AppRoutes.accountSettings,
                                );
                              },
                              showDivider: false,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // =====================================
                        // LOG OUT
                        // =====================================

                        ProfileLogoutButton(
                          onPressed: () {
                            _showLogoutDialog(context);
                          },
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================

      bottomNavigationBar:
      const BottomNavBarWidget(
        currentIndex: 3,
      ),
    );
  }

  // =====================================================
  // SECTION TITLE
  // =====================================================

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 17,
        height: 1.2,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF073F38),
      ),
    );
  }
}