import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

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
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Preferences saved successfully.',
          style: GoogleFonts.inter(
            fontSize: 11,
          ),
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

                  Text(
                    'Preferences',
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
                    // PREFERENCES CARD
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
                        children: [
                          // Course Updates
                          _PreferenceTile(
                            icon: Icons.notifications_none_rounded,
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

                          // Offers & Newsletter
                          _PreferenceTile(
                            icon: Icons.local_offer_outlined,
                            title: 'Offers & Newsletter',
                            subtitle:
                            'Receive special discounts and recommendations.',
                            value: _offersNewsletter,
                            onChanged: (value) {
                              setState(() {
                                _offersNewsletter = value;
                              });
                            },
                          ),

                          const SizedBox(height: 10),

                          // Language
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
// PREFERENCE TILE
// =====================================================

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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 19,
              color: const Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 11),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF073F38),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF71807C),
                    fontSize: 9.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor:
            const Color(0xFF8BB8AD),
            activeThumbColor:
            const Color(0xFF075E4D),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// LANGUAGE TILE
// =====================================================

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
        horizontal: 12,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.language_rounded,
              size: 19,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 11),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Language',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF073F38),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Choose your preferred app language.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF71807C),
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Dropdown
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: language,

              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 19,
                color: Color(0xFF71807C),
              ),

              style: GoogleFonts.inter(
                color: const Color(0xFF073F38),
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
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