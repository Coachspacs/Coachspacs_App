import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingBottomActions extends StatelessWidget {
  const OnboardingBottomActions({
    super.key,
    required this.onSkip,
    required this.onNext,
    required this.isLastPage,
  });

  final VoidCallback onSkip;
  final VoidCallback onNext;
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        10,
        20,
        20,
      ),
      child: Row(
        children: [
          // =====================================================
          // SKIP
          // =====================================================

          Expanded(
            child: TextButton(
              onPressed: onSkip,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
              ),
              child: Text(
                'Skip',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7A8985),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // =====================================================
          // NEXT / GET STARTED
          // =====================================================

          Expanded(
            flex: 2,
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF075E4D),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(
                      isLastPage
                          ? 'Get Started'
                          : 'Next',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(width: 7),

                    Icon(
                      isLastPage
                          ? Icons.arrow_forward_rounded
                          : Icons.arrow_forward_rounded,
                      size: 17,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}