import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorProfileMenuItem extends StatelessWidget {
  const InstructorProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Row(
          children: [
            // =================================================
            // ICON
            // =================================================

            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5F2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 18,
                color: const Color(0xFF075E4D),
              ),
            ),

            const SizedBox(width: 12),

            // =================================================
            // TEXT
            // =================================================

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF173D37),
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF7B8985),
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // ARROW
            // =================================================

            const Icon(
              Icons.chevron_right_rounded,
              size: 19,
              color: Color(0xFF8A9894),
            ),
          ],
        ),
      ),
    );
  }
}