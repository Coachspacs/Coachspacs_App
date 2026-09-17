import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() =>
      _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState
    extends State<SecuritySettingsScreen> {
  final TextEditingController _currentPasswordController =
  TextEditingController();

  final TextEditingController _newPasswordController =
  TextEditingController();

  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your new password.',
            style: GoogleFonts.inter(fontSize: 11),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (_newPasswordController.text !=
        _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'New passwords do not match.',
            style: GoogleFonts.inter(fontSize: 11),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Security settings saved successfully.',
          style: GoogleFonts.inter(fontSize: 11),
        ),
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
            // =====================================================
            // HEADER
            // =====================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                18,
                16,
                12,
              ),
              child: Row(
                children: [
                  // Back Arrow
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 25,
                      color: Color(0xFF073F38),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Title
                  Text(
                    'Security',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF073F38),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  12,
                  16,
                  30,
                ),
                child: Column(
                  children: [
                    // =================================================
                    // PASSWORD CARD
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFDCE7E4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          // Current Password
                          _PasswordField(
                            label: 'Current Password',
                            controller:
                            _currentPasswordController,
                            obscureText: _obscureCurrent,
                            onToggle: () {
                              setState(() {
                                _obscureCurrent =
                                !_obscureCurrent;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          // New Password
                          _PasswordField(
                            label: 'New Password',
                            controller:
                            _newPasswordController,
                            obscureText: _obscureNew,
                            onToggle: () {
                              setState(() {
                                _obscureNew =
                                !_obscureNew;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          // Confirm Password
                          _PasswordField(
                            label: 'Confirm New Password',
                            controller:
                            _confirmPasswordController,
                            obscureText: _obscureConfirm,
                            onToggle: () {
                              setState(() {
                                _obscureConfirm =
                                !_obscureConfirm;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 42),

                    // =================================================
                    // SAVE BUTTON
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _saveChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(26),
                          ),
                        ),
                        child: Text(
                          'Save Changes',
                          style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
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

// =====================================================
// PASSWORD FIELD
// =====================================================

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.obscureText,
    required this.onToggle,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF073F38),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 46,
          child: TextField(
            controller: controller,
            obscureText: obscureText,

            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF344842),
            ),

            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,

              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),

              suffixIcon: IconButton(
                onPressed: onToggle,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 19,
                  color: const Color(0xFF71807C),
                ),
              ),

              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(11),
                borderSide: const BorderSide(
                  color: Color(0xFFD5E1DE),
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(11),
                borderSide: const BorderSide(
                  color: Color(0xFFD5E1DE),
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(11),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}