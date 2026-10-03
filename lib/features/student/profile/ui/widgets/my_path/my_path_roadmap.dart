import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPathRoadmap extends StatelessWidget {
  const MyPathRoadmap({super.key});

  static const Color primary = Color(0xFF075E4D);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 208,
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3F0),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFD2E9E5),
        ),
      ),
      child: Stack(
        children: [
          // =====================================================
          // AI GUIDED ROADMAP
          // =====================================================

          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: Color(0xFFFFB300),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'AI Guided Roadmap',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =====================================================
          // ACTIVE PLAN
          // =====================================================

          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFF42D3A5),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Active Plan',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =====================================================
          // ANIMATION PLACEHOLDER
          // =====================================================

          const Center(
            child: Icon(
              Icons.route_rounded,
              size: 42,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }
}