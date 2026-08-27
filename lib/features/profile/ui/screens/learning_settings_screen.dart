import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/settings/settings_tabs.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Learning preferences saved successfully.',
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
            _SettingsHeader(
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

                        _SettingsCard(
                          children: [
                            _FieldLabel(
                              title: 'Primary Learning Goal',
                            ),

                            const SizedBox(height: 7),

                            _SettingsTextField(
                              controller: _goalController,
                            ),

                            const SizedBox(height: 18),

                            _FieldLabel(
                              title: 'Preferred Field',
                            ),

                            const SizedBox(height: 7),

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

                            _FieldLabel(
                              title:
                              'Name on Official Certificates',
                            ),

                            const SizedBox(height: 7),

                            _SettingsTextField(
                              controller:
                              _certificateNameController,
                            ),

                            const SizedBox(height: 18),

                            _FieldLabel(
                              title:
                              'Default Video Playback Speed',
                            ),

                            const SizedBox(height: 7),

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

                            const SizedBox(height: 20),

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

                        const SizedBox(height: 18),

                        _SaveButton(
                          onPressed: _saveChanges,
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

// =====================================================
// HEADER
// =====================================================

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader({
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

// =====================================================
// CARD
// =====================================================

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

// =====================================================
// LABEL
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
        color: AppColors.textBody,
        fontSize: 11,
        fontWeight: FontWeight.w600,
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
    return TextField(
      controller: controller,
      style: GoogleFonts.inter(
        color: AppColors.textBody,
        fontSize: 11,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFBFCFC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primary,
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
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      style: GoogleFonts.inter(
        color: AppColors.textBody,
        fontSize: 11,
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 19,
        color: AppColors.textLight,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFBFCFC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
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
      items: items.map(
            (item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.inter(
                fontSize: 11,
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFA),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: AppColors.border,
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
                    height: 1.3,
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

// =====================================================
// SAVE BUTTON
// =====================================================

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 43,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Save Changes',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}