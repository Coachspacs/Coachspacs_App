import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/settings/avatar_section.dart';
import 'package:coach_space/features/profile/ui/widgets/settings/settings_field.dart';
import 'package:coach_space/features/profile/ui/widgets/settings/settings_header.dart';
import 'package:coach_space/features/profile/ui/widgets/settings/settings_tabs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _fullNameController =
  TextEditingController(text: 'hadeelbaroud9');

  final _emailController =
  TextEditingController(text: 'hadeelbaroud9@gmail.com');

  final _phoneController =
  TextEditingController(text: '+966 55 123 4567');

  final _jobTitleController =
  TextEditingController(text: 'Data Science & AI Enthusiast');

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SettingsHeader(),

                  const SizedBox(height: 20),

                  const SettingsTabs(),

                  const SizedBox(height: 20),

                  const AvatarSection(),

                  const SizedBox(height: 24),

                  SettingsField(
                    label: 'Full Name',
                    controller: _fullNameController,
                  ),

                  const SizedBox(height: 16),

                  SettingsField(
                    label: 'Email Address',
                    controller: _emailController,
                    showChange: true,
                  ),

                  const SizedBox(height: 16),

                  SettingsField(
                    label: 'Phone Number',
                    controller: _phoneController,
                  ),

                  const SizedBox(height: 16),

                  SettingsField(
                    label: 'Headline / Job Title',
                    controller: _jobTitleController,
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Profile changes saved successfully.',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B624F),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}