import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'New passwords do not match.',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor:
          const Color(0xFFD9534F),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Password updated successfully.',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor:
        const Color(0xFF075E4D),
        behavior: SnackBarBehavior.floating,
      ),
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
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color:
                        const Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Keep your account secure with a strong password.',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        height: 1.45,
                        color:
                        const Color(0xFF788681),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // CURRENT PASSWORD
                    // =================================================

                    _PasswordField(
                      label: 'Current Password',
                      controller:
                      _currentPassword,
                      obscureText: !_showCurrent,
                      onVisibilityTap: () {
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

                    _PasswordField(
                      label: 'New Password',
                      controller: _newPassword,
                      obscureText: !_showNew,
                      onVisibilityTap: () {
                        setState(() {
                          _showNew = !_showNew;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // =================================================
                    // CONFIRM PASSWORD
                    // =================================================

                    _PasswordField(
                      label: 'Confirm New Password',
                      controller:
                      _confirmPassword,
                      obscureText:
                      !_showConfirm,
                      onVisibilityTap: () {
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
                              fontSize: 9,
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

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF075E4D),
                          foregroundColor:
                          Colors.white,
                          elevation: 0,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(11),
                          ),
                        ),
                        child: Text(
                          'Save Changes  →',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                      ),
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
// PASSWORD FIELD
// =============================================================

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.onVisibilityTap,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onVisibilityTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF344540),
          ),
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          obscureText: obscureText,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: const Color(0xFF173D37),
          ),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: const TextStyle(
              fontSize: 11,
              color: Color(0xFFA0ACA8),
            ),
            suffixIcon: IconButton(
              onPressed: onVisibilityTap,
              splashColor: Colors.transparent,
              highlightColor:
              Colors.transparent,
              icon: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 17,
                color:
                const Color(0xFF788681),
              ),
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