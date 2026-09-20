import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';

class LoginRequiredDialog {
  LoginRequiredDialog._();

  static Future<void> show(BuildContext context) async {
    final shouldLogin = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 28,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              22,
              22,
              22,
              18,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // =====================================================
                // ICON
                // =====================================================

                Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE6F5F0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    size: 25,
                    color: Color(0xFF075E4D),
                  ),
                ),

                const SizedBox(height: 15),

                // =====================================================
                // TITLE
                // =====================================================

                Text(
                  'Login Required',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textBody,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 8),

                // =====================================================
                // DESCRIPTION
                // =====================================================

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    'Please log in to your account to continue '
                        'with this action.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      height: 1.55,
                      color: AppColors.textLight,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =====================================================
                // BUTTONS
                // =====================================================

                Row(
                  children: [
                    // -------------------------------------------------
                    // CANCEL
                    // -------------------------------------------------

                    Expanded(
                      child: SizedBox(
                        height: 43,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                              false,
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor:
                            AppColors.textLight,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(11),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textLight,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    // -------------------------------------------------
                    // GO TO LOGIN
                    // -------------------------------------------------

                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 43,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                              true,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(11),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                'Go to Login',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),

                              const SizedBox(width: 6),

                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    // =====================================================
    // GO TO LOGIN
    // =====================================================

    if (shouldLogin == true && context.mounted) {
      Navigator.pushNamed(
        context,
        AppRoutes.login,
      );
    }
  }
}