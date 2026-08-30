import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

import '../widgets/settings/settings_tabs.dart';

class PreferencesSettingsScreen extends StatefulWidget {
  const PreferencesSettingsScreen({super.key});

  @override
  State<PreferencesSettingsScreen> createState() =>
      _PreferencesSettingsScreenState();
}

class _PreferencesSettingsScreenState
    extends State<PreferencesSettingsScreen> {
  bool _courseUpdates = true;
  bool _offersNewsletter = false;

  String _language = 'English';

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Preferences saved successfully.',
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

                        Text(
                          'Manage your notification and app preferences.',
                          style: GoogleFonts.inter(
                            color: AppColors.textLight,
                            fontSize: 10,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                            BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.border,
                            ),
                          ),
                          child: Column(
                            children: [
                              _PreferenceTile(
                                icon:
                                Icons.notifications_none_rounded,
                                title: 'Course Updates',
                                subtitle:
                                'Notifications for new lessons and content.',
                                value: _courseUpdates,
                                onChanged: (value) {
                                  setState(() {
                                    _courseUpdates = value;
                                  });
                                },
                              ),

                              const SizedBox(height: 10),

                              _PreferenceTile(
                                icon:
                                Icons.local_offer_outlined,
                                title:
                                'Offers & Newsletter',
                                subtitle:
                                'Receive special discounts and recommendations.',
                                value:
                                _offersNewsletter,
                                onChanged: (value) {
                                  setState(() {
                                    _offersNewsletter =
                                        value;
                                  });
                                },
                              ),

                              const SizedBox(height: 10),

                              _LanguageTile(
                                language: _language,
                                onChanged: (value) {
                                  setState(() {
                                    _language = value;
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

class _PreferenceTile extends StatelessWidget {
  const _PreferenceTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFA),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              icon,
              size: 18,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: AppColors.textBody,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: AppColors.textLight,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.onChanged,
  });

  final String language;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFA),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.language_rounded,
              size: 18,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Language',
                  style: GoogleFonts.inter(
                    color: AppColors.textBody,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Choose your preferred app language.',
                  style: GoogleFonts.inter(
                    color: AppColors.textLight,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),

          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: language,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: AppColors.textLight,
              ),
              style: GoogleFonts.inter(
                color: AppColors.textBody,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'English',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'Arabic',
                  child: Text('العربية'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}