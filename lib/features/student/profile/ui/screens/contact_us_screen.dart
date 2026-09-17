import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({
    super.key,
  });

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _messageController =
  TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter your message.',
            style: GoogleFonts.inter(
              fontSize: 12,
            ),
          ),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

      return;
    }

    // API integration will be added later.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Your message has been sent successfully.',
          style: GoogleFonts.inter(
            fontSize: 12,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    _messageController.clear();
  }

  void _cancelMessage() {
    _messageController.clear();
    FocusScope.of(context).unfocus();
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
                14,
                16,
                0,
              ),
              child: Row(
                children: [
                  // Back Button
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
                      size: 24,
                      color: Color(0xFF073F38),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    'Contact us',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF171616),
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
                  20,
                  28,
                  20,
                  30,
                ),
                child: Column(
                  children: [
                    // ------------------------------------------------
                    // DESCRIPTION
                    // ------------------------------------------------

                    Text(
                      'Have a question or need assistance? Our\n'
                          'team is here to help you get the most out of\n'
                          'your coaching journey.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4D5855),
                        height: 1.7,
                      ),
                    ),

                    const SizedBox(height: 54),

                    // ------------------------------------------------
                    // MESSAGE CARD
                    // ------------------------------------------------

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        24,
                        30,
                        24,
                        34,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE2E8E6),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.04,
                            ),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          // Card Title
                          Text(
                            'Send a Message',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF172B27),
                            ),
                          ),

                          const SizedBox(height: 26),

                          // Message Label
                          Text(
                            'Message',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF4D5855),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Message Field
                          TextField(
                            controller: _messageController,
                            maxLines: 5,
                            textAlignVertical:
                            TextAlignVertical.top,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFF172B27),
                            ),
                            decoration: InputDecoration(
                              hintText:
                              'Describe your issue in detail...',
                              hintStyle: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xFF99A7A5),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFE6F5FC),
                              contentPadding:
                              const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(9),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(9),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(9),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 23),

                          // ------------------------------------------------
                          // SEND BUTTON
                          // ------------------------------------------------

                          SizedBox(
                            width: double.infinity,
                            height: 57,
                            child: ElevatedButton(
                              onPressed: _sendMessage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                AppColors.primary,
                                foregroundColor: Colors.white,
                                elevation: 5,
                                shadowColor:
                                AppColors.primary.withValues(
                                  alpha: 0.30,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Send Message',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  const Icon(
                                    Icons.send_outlined,
                                    size: 17,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // ------------------------------------------------
                          // CANCEL
                          // ------------------------------------------------

                          Center(
                            child: TextButton(
                              onPressed: _cancelMessage,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                foregroundColor:
                                const Color(0xFF172B27),
                              ),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
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