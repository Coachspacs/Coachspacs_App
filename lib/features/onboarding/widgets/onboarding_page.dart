import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.accentLabel,
  });

  final String title;
  final String description;
  final String image;
  final String accentLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        24,
        20,
        24,
        10,
      ),
      child: Column(
        children: [
          const Spacer(),

          // =====================================================
          // ILLUSTRATION
          // =====================================================

          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xFFE7F5F0),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 185,
                  height: 185,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDDF3EB),
                    shape: BoxShape.circle,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),

                Positioned(
                  top: 28,
                  right: 30,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.04,
                          ),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Text(
                      accentLabel,
                      style: GoogleFonts.inter(
                        fontSize: 7,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF075E4D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 38),

          // =====================================================
          // TITLE
          // =====================================================

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20,
              height: 1.15,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 14),

          // =====================================================
          // DESCRIPTION
          // =====================================================

          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              height: 1.65,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF71807C),
            ),
          ),

          const Spacer(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}