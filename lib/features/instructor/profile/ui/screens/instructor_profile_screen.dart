import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';

import 'package:coach_space/features/instructor/students/ui/widgets/instructor_students_header.dart';

import 'package:coach_space/features/instructor/profile/ui/widgets/instructor_profile_user_card.dart';
import 'package:coach_space/features/instructor/profile/ui/widgets/instructor_profile_section.dart';
import 'package:coach_space/features/instructor/profile/ui/widgets/instructor_profile_menu_item.dart';

import 'package:coach_space/features/instructor/profile/ui/screens/instructor_social_links_screen.dart';
import 'package:coach_space/features/instructor/profile/ui/screens/instructor_payout_screen.dart';
import 'package:coach_space/features/instructor/profile/ui/screens/instructor_security_screen.dart';

import 'instructor_basic_info_screen.dart';

class InstructorProfileScreen extends StatelessWidget {
  const InstructorProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      // =====================================================
      // BODY
      // =====================================================

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // APP HEADER
            // =================================================

            const InstructorStudentsHeader(
              showProfile: false,
            ),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  24,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // PAGE TITLE
                    // =================================================

                    Text(
                      'Account Settings',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Manage your instructor profile and account.',
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF788681),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =================================================
                    // USER CARD
                    // =================================================

                    InstructorProfileUserCard(
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const InstructorBasicInfoScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // PROFILE & SKILLS
                    // =================================================

                    InstructorProfileSection(
                      title: 'Profile & Skills',
                      children: [
                        // =================================================
                        // BASIC INFO
                        // =================================================

                        InstructorProfileMenuItem(
                          icon: Icons.person_outline_rounded,
                          title: 'Basic Info & Skills',
                          subtitle:
                          'Name, specialization and experience',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const InstructorBasicInfoScreen(),
                              ),
                            );
                          },
                        ),

                        // =================================================
                        // SOCIAL LINKS
                        // =================================================

                        InstructorProfileMenuItem(
                          icon: Icons.link_rounded,
                          title: 'Social Links',
                          subtitle:
                          'Connect your professional profiles',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const InstructorSocialLinksScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // ACCOUNT
                    // =================================================

                    InstructorProfileSection(
                      title: 'Account',
                      children: [
                        // =================================================
                        // PAYOUT & BILLING
                        // =================================================

                        InstructorProfileMenuItem(
                          icon: Icons
                              .account_balance_wallet_outlined,
                          title: 'Payout & Billing',
                          subtitle:
                          'Manage earnings and payment details',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const InstructorPayoutScreen(),
                              ),
                            );
                          },
                        ),

                        // =================================================
                        // SECURITY
                        // =================================================

                        InstructorProfileMenuItem(
                          icon: Icons.lock_outline_rounded,
                          title: 'Security & Password',
                          subtitle:
                          'Password and account security',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const InstructorSecurityScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // SIGN OUT
                    // =================================================

                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          _showLogoutDialog(context);
                        },
                        icon: const Icon(
                          Icons.logout_rounded,
                          size: 17,
                          color: Color(0xFFD9534F),
                        ),
                        label: Text(
                          'Sign Out',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFD9534F),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================

      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 3,
        navType: NavType.instructor,
        onItemSelected: (index) {
          _handleBottomNavigation(
            context,
            index,
          );
        },
      ),
    );
  }

  // =============================================================
  // BOTTOM NAVIGATION
  // =============================================================

  void _handleBottomNavigation(
      BuildContext context,
      int index,
      ) {
    switch (index) {
    // =================================================
    // DASHBOARD
    // =================================================

      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorDashboard,
              (route) => false,
        );
        break;

    // =================================================
    // COURSES
    // =================================================

      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorCourses,
              (route) => false,
        );
        break;

    // =================================================
    // STUDENTS
    // =================================================

      case 2:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorStudents,
              (route) => false,
        );
        break;

    // =================================================
    // PROFILE
    // =================================================

      case 3:
      // Already on Profile.
        break;
    }
  }

  // =============================================================
  // LOGOUT DIALOG
  // =============================================================

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Text(
            'Sign Out',
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF788681),
            ),
          ),
          actions: [
            // =================================================
            // CANCEL
            // =================================================

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF667570),
                ),
              ),
            ),

            // =================================================
            // SIGN OUT
            // =================================================

            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF075E4D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: Text(
                'Sign Out',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}