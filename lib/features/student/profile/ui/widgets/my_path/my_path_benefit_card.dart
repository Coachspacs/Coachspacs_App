import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPathBenefitCard extends StatelessWidget {
  const MyPathBenefitCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  static const Color primary = Color(0xFF075E4D);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE1EAE7),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF0FBF7),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(
                color: const Color(0xFFCDEDE1),
              ),
            ),
            child: Icon(
              icon,
              size: 19,
              color: primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF253A3A),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    height: 1.5,
                    color: const Color(0xFF667B80),
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