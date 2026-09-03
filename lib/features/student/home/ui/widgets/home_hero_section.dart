import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/widgets/login_required_dialog.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        0,
      ),
      padding: const EdgeInsets.fromLTRB(
        18,
        16,
        18,
        18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F6F1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD5EAE3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =================================================
          // WELCOME BADGE
          // =================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD4F3E9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'WELCOME BACK',
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // =================================================
          // MAIN TITLE
          // =================================================

          Text(
            'Master New Skills with\nExpert Coaches',
            style: GoogleFonts.inter(
              fontSize: 24,
              height: 1.12,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 9),

          // =================================================
          // DESCRIPTION
          // =================================================

          Text(
            'Unlock your potential through personalized '
                'learning paths led by industry veterans. '
                'From design to development, gain the edge '
                'you need in the modern professional landscape.',
            style: GoogleFonts.inter(
              fontSize: 10.5,
              height: 1.5,
              color: const Color(0xFF5F716C),
            ),
          ),

          const SizedBox(height: 18),

          // =================================================
          // BUTTONS
          // =================================================

          Row(
            children: [
              // =================================================
              // MY COURSES
              // =================================================

              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      LoginRequiredDialog.show(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF075E4D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'My Courses  →',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // =================================================
              // EXPLORE NEW COURSES
              // =================================================

              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.catalog,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF075E4D),
                      side: const BorderSide(
                        color: Color(0xFF075E4D),
                      ),
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Explore New Courses',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // =================================================
          // STATS
          // =================================================

          Container(
            height: 118,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFFDCE7E4),
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // =================================================
                // BACKGROUND LOGO
                // =================================================

                Image.asset(
                  'assets/images/Logo_img.png',
                  fit: BoxFit.contain,
                  opacity: const AlwaysStoppedAnimation(0.08),
                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return const SizedBox.shrink();
                  },
                ),

                // =================================================
                // STATS
                // =================================================

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    const _StatItem(
                      icon: Icons.people_alt_outlined,
                      value: '12k+',
                      label: 'Active Students',
                    ),

                    Container(
                      width: 1,
                      height: 48,
                      color: const Color(0xFFDCE7E4),
                    ),

                    const _StatItem(
                      icon: Icons.workspace_premium_outlined,
                      value: '2k+',
                      label: 'Certificates Issued',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// STAT ITEM
// =====================================================

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            color: Color(0xFFDDF3EB),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.people_alt_outlined,
            size: 16,
            color: Color(0xFF075E4D),
          ),
        ),

        const SizedBox(height: 5),

        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 8,
            color: const Color(0xFF71807C),
          ),
        ),
      ],
    );
  }
}