import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import '../widgets/settings/settings_tabs.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() =>
      _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState
    extends State<SecuritySettingsScreen> {
  final _currentPasswordController =
  TextEditingController();

  final _newPasswordController =
  TextEditingController();

  final _confirmPasswordController =
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
            _Header(
              onBack: () {
                Navigator.pop(context);
              },
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  4,
                  16,
                  30,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 700,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const SettingsTabs(),

                        const SizedBox(height: 18),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                            BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.border,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              _PasswordField(
                                label: 'Current Password',
                                controller:
                                _currentPasswordController,
                                obscureText:
                                _obscureCurrent,
                                onToggle: () {
                                  setState(() {
                                    _obscureCurrent =
                                    !_obscureCurrent;
                                  });
                                },
                              ),

                              const SizedBox(height: 16),

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

                              const SizedBox(height: 16),

                              _PasswordField(
                                label:
                                'Confirm New Password',
                                controller:
                                _confirmPasswordController,
                                obscureText:
                                _obscureConfirm,
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

                        const SizedBox(height: 18),

                        SizedBox(
                          width: double.infinity,
                          height: 43,
                          child: ElevatedButton(
                            onPressed: _saveChanges,
                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor:
                              AppColors.primary,
                              foregroundColor:
                              AppColors.white,
                              elevation: 0,
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Save Changes',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        10,
        8,
        16,
        4,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 34,
              minHeight: 34,
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 23,
              color: Color(0xFF073F38),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            'Student Settings',
            style: GoogleFonts.inter(
              color: const Color(0xFF073F38),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

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
            color: AppColors.textBody,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          obscureText: obscureText,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textBody,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFBFCFC),
            contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 18,
                color: AppColors.textLight,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),
          ),
        ),
      ],
    );
  }
}