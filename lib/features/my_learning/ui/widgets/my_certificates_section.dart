import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCertificatesSection extends StatelessWidget {
  const MyCertificatesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'My Certificates',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize:
                MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF9F5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFD5EAE3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xFFD5F2E8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium_outlined,
                  color: Color(0xFF075E4D),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full-Stack Development',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF073F38),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Certificate earned',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: const Color(0xFF71807C),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF71807C),
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}