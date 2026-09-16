import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.onboarding,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF9),
      body: Stack(
        children: [
          // =====================================================
          // TOP DECORATION
          // =====================================================

          Positioned(
            top: -70,
            right: -55,
            child: Container(
              width: 190,
              height: 190,
              decoration: const BoxDecoration(
                color: Color(0xFFE2F3ED),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // =====================================================
          // BOTTOM DECORATION
          // =====================================================

          Positioned(
            bottom: -85,
            left: -65,
            child: Container(
              width: 190,
              height: 190,
              decoration: const BoxDecoration(
                color: Color(0xFFE2F3ED),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // =====================================================
          // SMALL DECORATION
          // =====================================================

          Positioned(
            top: 145,
            left: -35,
            child: Container(
              width: 75,
              height: 75,
              decoration: const BoxDecoration(
                color: Color(0xFFEDF8F4),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // =====================================================
          // CONTENT
          // =====================================================

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // -------------------------------------------------
                // LOGO CIRCLE
                // -------------------------------------------------

                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD9E8E3),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.04,
                        ),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Image.asset(
                    'assets/images/Logo_img.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 24),

                // -------------------------------------------------
                // APP NAME
                // -------------------------------------------------

                Text(
                  'Coach Space',
                  style: GoogleFonts.inter(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF073F38),
                    letterSpacing: -0.7,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}