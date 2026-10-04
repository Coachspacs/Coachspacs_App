import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/snackbar_helper.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/instructor/profile/ui/widgets/instructor_save_button.dart';
import 'package:coach_space/features/instructor/profile/ui/widgets/instructor_settings_header.dart';

class InstructorSocialLinksScreen extends StatefulWidget {
  const InstructorSocialLinksScreen({
    super.key,
  });

  @override
  State<InstructorSocialLinksScreen> createState() =>
      _InstructorSocialLinksScreenState();
}

class _InstructorSocialLinksScreenState
    extends State<InstructorSocialLinksScreen> {
  final TextEditingController _websiteController =
  TextEditingController(
    text: 'https://yourwebsite.com',
  );

  final TextEditingController _linkedinController =
  TextEditingController(
    text: 'https://linkedin.com/in/username',
  );

  final TextEditingController _twitterController =
  TextEditingController(
    text: 'https://x.com/username',
  );

  final TextEditingController _githubController =
  TextEditingController(
    text: 'https://github.com/username',
  );

  @override
  void dispose() {
    _websiteController.dispose();
    _linkedinController.dispose();
    _twitterController.dispose();
    _githubController.dispose();

    super.dispose();
  }

  void _saveChanges() {
    showAppSnackBar(
      context,
      'Social links saved successfully.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [
            const InstructorSettingsHeader(
              title: 'Social Links',
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  18,
                  16,
                  28,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // INTRO
                    // =================================================

                    Text(
                      'Connect your professional profiles',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Add your social links so students can learn more about you.',
                      style: GoogleFonts.inter(

                        fontSize: 12,
                        height: 1.45,
                        color: const Color(0xFF788681),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // WEBSITE
                    // =================================================

                    _SocialField(
                      label: 'Website URL',
                      icon: Icons.language_rounded,
                      hint: 'https://yourwebsite.com',
                      controller: _websiteController,
                    ),

                    const SizedBox(height: 15),

                    // =================================================
                    // LINKEDIN
                    // =================================================

                    _SocialField(
                      label: 'LinkedIn Profile URL',
                      icon: Icons.business_center_outlined,
                      hint: 'https://linkedin.com/in/username',
                      controller: _linkedinController,
                    ),

                    const SizedBox(height: 15),

                    // =================================================
                    // X / TWITTER
                    // =================================================

                    _SocialField(
                      label: 'X / Twitter Profile URL',
                      icon: Icons.close_rounded,
                      hint: 'https://x.com/username',
                      controller: _twitterController,
                    ),

                    const SizedBox(height: 15),

                    // =================================================
                    // GITHUB
                    // =================================================

                    _SocialField(
                      label: 'GitHub Profile URL',
                      icon: Icons.code_rounded,
                      hint: 'https://github.com/username',
                      controller: _githubController,
                    ),

                    const SizedBox(height: 28),

                    // =================================================
                    // SAVE
                    // =================================================

                    InstructorSaveButton(
                      onPressed: _saveChanges,
                    ),
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

// =============================================================
// SOCIAL FIELD
// =============================================================

class _SocialField extends StatelessWidget {
  const _SocialField({
    required this.label,
    required this.icon,
    required this.hint,
    required this.controller,
  });

  final String label;
  final IconData icon;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 13,
              color: const Color(0xFF075E4D),
            ),

            const SizedBox(width: 6),

            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF344540),
              ),
            ),
          ],
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          keyboardType: TextInputType.url,
          style: GoogleFonts.inter(
            fontSize: 12.5,
            color: const Color(0xFF173D37),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFFA0ACA8),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFFDDE8E5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFFDDE8E5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Color(0xFF075E4D),
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
