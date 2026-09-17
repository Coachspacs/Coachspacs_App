import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class LearningSettingsScreen extends StatefulWidget {
  const LearningSettingsScreen({super.key});

  @override
  State<LearningSettingsScreen> createState() =>
      _LearningSettingsScreenState();
}

class _LearningSettingsScreenState
    extends State<LearningSettingsScreen> {
  final TextEditingController _goalController =
  TextEditingController(
    text: 'Build practical skills for my career',
  );

  final TextEditingController _certificateNameController =
  TextEditingController(
    text: 'Sondos Abu Skhail',
  );

  String _preferredField = 'Data Science & AI';
  String _playbackSpeed = '1.0x Normal';

  bool _publicProfile = true;

  @override
  void dispose() {
    _goalController.dispose();
    _certificateNameController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Changes saved successfully.',
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
                    'Learning & Certificates',
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
                    // SETTINGS CARD
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
                          // =================================================
                          // PRIMARY LEARNING GOAL
                          // =================================================

                          _FieldLabel(
                            title: 'Primary Learning Goal',
                          ),

                          const SizedBox(height: 8),

                          _SettingsTextField(
                            controller: _goalController,
                          ),

                          const SizedBox(height: 18),

                          // =================================================
                          // PREFERRED FIELD
                          // =================================================

                          _FieldLabel(
                            title: 'Preferred Field',
                          ),

                          const SizedBox(height: 8),

                          _SettingsDropdown(
                            value: _preferredField,
                            items: const [
                              'Data Science & AI',
                              'Software Development',
                              'UI/UX Design',
                              'Business',
                            ],
                            onChanged: (value) {
                              setState(() {
                                _preferredField = value;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          // =================================================
                          // CERTIFICATE NAME
                          // =================================================

                          _FieldLabel(
                            title:
                            'Name on Official Certificates',
                          ),

                          const SizedBox(height: 8),

                          _SettingsTextField(
                            controller:
                            _certificateNameController,
                          ),

                          const SizedBox(height: 18),

                          // =================================================
                          // PLAYBACK SPEED
                          // =================================================

                          _FieldLabel(
                            title:
                            'Default Video Playback Speed',
                          ),

                          const SizedBox(height: 8),

                          _SettingsDropdown(
                            value: _playbackSpeed,
                            items: const [
                              '0.75x',
                              '1.0x Normal',
                              '1.25x',
                              '1.5x',
                              '2.0x',
                            ],
                            onChanged: (value) {
                              setState(() {
                                _playbackSpeed = value;
                              });
                            },
                          ),

                          const SizedBox(height: 18),

                          // =================================================
                          // PUBLIC PROFILE
                          // =================================================

                          _ToggleTile(
                            title: 'Public Student Profile',
                            subtitle:
                            'Allow fellow students and mentors to view your completed achievements.',
                            value: _publicProfile,
                            onChanged: (value) {
                              setState(() {
                                _publicProfile = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 42),

                    // =====================================================
                    // SAVE BUTTON
                    // =====================================================

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
// FIELD LABEL
// =====================================================

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: const Color(0xFF073F38),
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

// =====================================================
// TEXT FIELD
// =====================================================

class _SettingsTextField extends StatelessWidget {
  const _SettingsTextField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextField(
        controller: controller,
        style: GoogleFonts.inter(
          color: const Color(0xFF344842),
          fontSize: 13,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,

          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFFD5E1DE),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFFD5E1DE),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================
// DROPDOWN
// =====================================================

class _SettingsDropdown extends StatelessWidget {
  const _SettingsDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,

        style: GoogleFonts.inter(
          color: const Color(0xFF344842),
          fontSize: 13,
        ),

        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 20,
          color: Color(0xFF344842),
        ),

        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,

          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFFD5E1DE),
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFFD5E1DE),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 1.2,
            ),
          ),
        ),

        items: items.map(
              (item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF344842),
                ),
              ),
            );
          },
        ).toList(),

        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}

// =====================================================
// TOGGLE
// =====================================================

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        14,
        13,
        10,
        13,
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

                const SizedBox(height: 4),

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