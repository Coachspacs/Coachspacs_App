import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/instructor/profile/ui/widgets/instructor_settings_header.dart';

class InstructorPayoutScreen extends StatefulWidget {
  const InstructorPayoutScreen({
    super.key,
  });

  @override
  State<InstructorPayoutScreen> createState() =>
      _InstructorPayoutScreenState();
}

class _InstructorPayoutScreenState
    extends State<InstructorPayoutScreen> {
  int _selectedMethod = 0;

  final TextEditingController _ibanController =
  TextEditingController(
    text: 'SA8100000000000010676529',
  );

  @override
  void dispose() {
    _ibanController.dispose();
    super.dispose();
  }

  // =============================================================
  // SAVE CHANGES
  // =============================================================

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Payout settings saved successfully.',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF075E4D),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // =============================================================
  // BUILD
  // =============================================================

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

            const InstructorSettingsHeader(
              title: 'Payout & Billing',
            ),

            // =====================================================
            // CONTENT
            // =====================================================

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
                    // PAYMENT METHOD LABEL
                    // =================================================

                    Text(
                      'Payment Method',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF344540),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // =================================================
                    // PAYMENT METHOD SELECTOR
                    // =================================================

                    Container(
                      width: double.infinity,
                      height: 45,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(10),
                        border: Border.all(
                          color:
                          const Color(0xFFDDE8E5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _PaymentMethod(
                              icon: Icons
                                  .account_balance_rounded,
                              title: 'Bank (IBAN)',
                              selected:
                              _selectedMethod == 0,
                              onTap: () {
                                setState(() {
                                  _selectedMethod = 0;
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 4),

                          Expanded(
                            child: _PaymentMethod(
                              icon: Icons.payment_rounded,
                              title: 'PayPal',
                              selected:
                              _selectedMethod == 1,
                              onTap: () {
                                setState(() {
                                  _selectedMethod = 1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // =================================================
                    // BANK IBAN
                    // =================================================

                    Text(
                      'Bank IBAN',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF344540),
                      ),
                    ),

                    const SizedBox(height: 7),

                    TextField(
                      controller: _ibanController,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF173D37),
                      ),
                      decoration: _inputDecoration(
                        hint: 'Enter your IBAN',
                        prefixIcon: Icons
                            .account_balance_outlined,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================================
                    // PENDING PAYOUT CARD
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5F2),
                        borderRadius:
                        BorderRadius.circular(14),
                        border: Border.all(
                          color:
                          const Color(0xFFD2EAE4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PENDING PAYOUT',
                            style: GoogleFonts.inter(

                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color:
                              const Color(0xFF5C8980),
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            '\$1,840.00',
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color:
                              const Color(0xFF073F38),
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Next payout cycle: May 1st',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color:
                              const Color(0xFF64817B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // =================================================
                    // SAVE BUTTON
                    // =================================================

                    _SaveButton(
                      onPressed: _saveChanges,
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

  // =============================================================
  // INPUT DECORATION
  // =============================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,

      hintStyle: GoogleFonts.inter(
        fontSize: 10,
        color: const Color(0xFFA0ACA8),
      ),

      prefixIcon: Icon(
        prefixIcon,
        size: 16,
        color: const Color(0xFF71837E),
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFDDE8E5),
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFFDDE8E5),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(
          color: Color(0xFF075E4D),
          width: 1.2,
        ),
      ),
    );
  }
}

// =============================================================
// PAYMENT METHOD
// =============================================================

class _PaymentMethod extends StatelessWidget {
  const _PaymentMethod({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 180,
          ),
          curve: Curves.easeOut,

          // =================================================
          // IMPORTANT:
          // Selected item gets a small pill background.
          // Unselected item stays transparent.
          // =================================================

          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 3,
          ),

          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFE2F3EE)
                : Colors.transparent,
            borderRadius:
            BorderRadius.circular(20),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 13,
                color: selected
                    ? const Color(0xFF075E4D)
                    : const Color(0xFF667570),
              ),

              const SizedBox(width: 5),

              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: selected
                      ? const Color(0xFF075E4D)
                      : const Color(0xFF667570),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================
// SAVE BUTTON
// =============================================================

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
          const Color(0xFF075E4D),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(11),
          ),
        ),
        child: Text(
          'Save Changes  →',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}