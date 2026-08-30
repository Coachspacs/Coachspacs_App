import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorOverviewCard extends StatelessWidget {
  const InstructorOverviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0EAE7),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F5F0),
                  borderRadius:
                  BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.insights_outlined,
                  size: 17,
                  color: Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructor Studio Overview',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color:
                        const Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      'Track your teaching performance',
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        color:
                        const Color(0xFF7B8985),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: const [
              Expanded(
                child: _OverviewItem(
                  value: '4.9',
                  label: 'Average Rating',
                  icon: Icons.star_rounded,
                ),
              ),

              SizedBox(width: 8),

              Expanded(
                child: _OverviewItem(
                  value: '87%',
                  label: 'Completion Rate',
                  icon: Icons.check_circle_outline,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: const [
              Expanded(
                child: _OverviewItem(
                  value: '92%',
                  label: 'Student Satisfaction',
                  icon: Icons.sentiment_satisfied_alt,
                ),
              ),

              SizedBox(width: 8),

              Expanded(
                child: _OverviewItem(
                  value: '18.4%',
                  label: 'Student Growth',
                  icon: Icons.trending_up,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================
// OVERVIEW ITEM
// =============================================================

class _OverviewItem extends StatelessWidget {
  const _OverviewItem({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF9),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: const Color(0xFF0F766E),
          ),

          const SizedBox(width: 7),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color:
                    const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 1),

                Text(
                  label,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 7,
                    color:
                    const Color(0xFF788681),
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