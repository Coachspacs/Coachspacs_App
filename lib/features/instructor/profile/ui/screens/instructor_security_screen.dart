import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/snackbar_helper.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/core/widgets/password_field.dart';
import 'package:coach_space/features/instructor/profile/ui/widgets/instructor_save_button.dart';
import 'package:coach_space/features/instructor/profile/ui/widgets/instructor_settings_header.dart';

class InstructorSecurityScreen extends StatefulWidget {
  const InstructorSecurityScreen({
    super.key,
  });

  @override
  State<InstructorSecurityScreen> createState() =>
      _InstructorSecurityScreenState();
}

class _InstructorSecurityScreenState
    extends State<InstructorSecurityScreen> {
  final TextEditingController _currentPassword =
  TextEditingController();

  final TextEditingController _newPassword =
  TextEditingController();

  final TextEditingController _confirmPassword =
  TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();

    super.dispose();
  }

  void _saveChanges() {
    if (_newPassword.text !=
        _confirmPassword.text) {
      showAppSnackBar(
        context,
        'New passwords do not match.',
        isError: true,
      );

      return;
    }

    showAppSnackBar(
      context,
      'Password updated successfully.',
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
              title: 'Security',
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
                    // TITLE
                    // =================================================

                    Text(
                      'Change Password',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color:
                        const Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Keep your account secure with a strong password.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        height: 1.45,
                        color:
                        const Color(0xFF788681),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // CURRENT PASSWORD
                    // =================================================

                    PasswordField(
                      label: 'Current Password',
                      controller:
                      _currentPassword,
                      obscureText: !_showCurrent,
                      onToggle: () {
                        setState(() {
                          _showCurrent =
                          !_showCurrent;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // NEW PASSWORD
                    // =================================================

                    PasswordField(
                      label: 'New Password',
                      controller: _newPassword,
                      obscureText: !_showNew,
                      onToggle: () {
                        setState(() {
                          _showNew = !_showNew;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // CONFIRM PASSWORD
                    // =================================================

                    PasswordField(
                      label: 'Confirm New Password',
                      controller:
                      _confirmPassword,
                      obscureText:
                      !_showConfirm,
                      onToggle: () {
                        setState(() {
                          _showConfirm =
                          !_showConfirm;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // PASSWORD HINT
                    // =================================================

                    Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 14,
                          color: Color(0xFF7C8C87),
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: Text(
                            'Use at least 8 characters with a mix of letters, numbers and symbols.',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              height: 1.4,
                              color:
                              const Color(0xFF7C8C87),
                            ),
                          ),
                        ),
                      ],
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
