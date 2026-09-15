import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState
    extends State<ProfileInformationScreen> {
  final TextEditingController _nameController =
  TextEditingController(text: 'sondos abu skhail');

  final TextEditingController _emailController =
  TextEditingController(text: 'abuskhailsondos@gmail.com');

  final TextEditingController _phoneController =
  TextEditingController();

  final TextEditingController _headlineController =
  TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _headlineController.dispose();
    super.dispose();
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
                      minWidth: 40,
                      minHeight: 40,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 25,
                      color: AppColors.textBody,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Text(
                    'Profile Information',
                    style: GoogleFonts.inter(
                      fontSize: 21,
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
                  4,
                  16,
                  30,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // AVATAR CARD
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE3EBE9),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 58,
                            height: 58,
                            decoration: const BoxDecoration(
                              color: Color(0xFF075E4D),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'S',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Avatar',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight:
                                    FontWeight.w700,
                                    color:
                                    const Color(0xFF182B28),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Upload a clear photo to help '
                                      'students recognize you.',
                                  style: GoogleFonts.inter(
                                    fontSize: 9.5,
                                    height: 1.35,
                                    color:
                                    const Color(0xFF71807C),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'JPG, PNG, WEBP UP TO 5MB.',
                                  style: GoogleFonts.inter(
                                    fontSize: 8.5,
                                    color:
                                    const Color(0xFF8A9995),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(
                                  0xFFDCE7E4,
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.cloud_upload_outlined,
                              size: 21,
                              color: Color(0xFF075E4D),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    _fieldLabel('Full Name'),

                    const SizedBox(height: 7),

                    _textField(
                      controller: _nameController,
                    ),

                    const SizedBox(height: 17),

                    Row(
                      children: [
                        Text(
                          'Email Address',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color:
                            const Color(0xFF263C38),
                          ),
                        ),

                        const Spacer(),

                        Text(
                          'Change',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF168F82),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    _textField(
                      controller: _emailController,
                      readOnly: true,
                    ),

                    const SizedBox(height: 17),

                    _fieldLabel('Phone Number'),

                    const SizedBox(height: 7),

                    _textField(
                      controller: _phoneController,
                    ),

                    const SizedBox(height: 17),

                    _fieldLabel('Headline / Job Title'),

                    const SizedBox(height: 7),

                    _textField(
                      controller: _headlineController,
                    ),

                    const SizedBox(height: 50),

                    // =================================================
                    // SAVE BUTTON
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content:
                              Text('Changes saved'),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          'Save Changes',
                          style: GoogleFonts.inter(
                            fontSize: 17,
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

  // =====================================================
  // FIELD LABEL
  // =====================================================

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF263C38),
      ),
    );
  }

  // =====================================================
  // TEXT FIELD
  // =====================================================

  Widget _textField({
    required TextEditingController controller,
    bool readOnly = false,
  }) {
    return SizedBox(
      height: 47,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
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
          ),
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFDCE5E3),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFDCE5E3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}