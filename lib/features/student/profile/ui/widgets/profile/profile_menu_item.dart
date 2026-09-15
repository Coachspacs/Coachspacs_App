import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 47,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                children: [
                  Icon(
                    icon,

                    size: 17,
                    color: const Color(0xFF637873),
                  ),

                  const SizedBox(width: 11),

                  Expanded(
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF263C38),
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: Color(0xFFA6B6B1),
                  ),
                ],
              ),
            ),
          ),
        ),

        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            indent: 12,
            endIndent: 12,
            color: Color(0xFFF0F4F3),
          ),
      ],
    );
  }
}