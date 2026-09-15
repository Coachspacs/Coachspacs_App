import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountSettingsOptionCard extends StatelessWidget {
  const AccountSettingsOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE6EEEB),
            ),
          ),
          child: Row(
            children: [
              // =====================================================
              // ICON
              // =====================================================

              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F8F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFDCEDE7),
                  ),
                ),
                child: Icon(
                  icon,
                  size: 21,
                  color: const Color(0xFF073F38),
                ),
              ),

              const SizedBox(width: 14),

              // =====================================================
              // TEXT
              // =====================================================

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF172438),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        height: 1.35,
                        color: const Color(0xFF697B92),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // =====================================================
              // ARROW
              // =====================================================

              const Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: Color(0xFFB7C6D1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}