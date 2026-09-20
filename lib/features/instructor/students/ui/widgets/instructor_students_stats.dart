import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorStudentsStats extends StatelessWidget {
  const InstructorStudentsStats({
    super.key,
    required this.total,
    required this.active,
    required this.completed,
    required this.avgCompletionPercent,
  });

  final int total;
  final int active;
  final int completed;
  final double avgCompletionPercent;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      crossAxisSpacing: 10,
      mainAxisSpacing: 10,

      // Keeps the cards responsive while giving them enough height.
      childAspectRatio: 1.38,

      children: [
        _StudentStatCard(
          icon: Icons.people_alt_outlined,
          value: '$total',
          title: 'Total Students',
          change: 'All',
          subtitle: 'Enrolled learners',
        ),

        _StudentStatCard(
          icon: Icons.bolt_outlined,
          value: '$active',
          title: 'Active Students',
          change: 'Active',
          subtitle: 'In progress',
        ),

        _StudentStatCard(
          icon: Icons.verified_outlined,
          value: '$completed',
          title: 'Completed',
          change: 'Done',
          subtitle: 'Finished courses',
        ),

        _StudentStatCard(
          icon: Icons.pie_chart_outline_rounded,
          value: '${avgCompletionPercent.round()}%',
          title: 'Avg Completion',
          change: 'Avg',
          subtitle: 'Across courses',
        ),
      ],
    );
  }
}

// =============================================================
// STAT CARD
// =============================================================

class _StudentStatCard extends StatelessWidget {
  const _StudentStatCard({
    required this.icon,
    required this.value,
    required this.title,
    required this.change,
    required this.subtitle,
  });

  final IconData icon;
  final String value;
  final String title;
  final String change;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        12,
        11,
        12,
        10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFDDE8E5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================================================
          // TOP ROW
          // ===================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 31,
                height: 31,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4F0),
                  borderRadius: BorderRadius.circular(9),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 16,
                  color: const Color(0xFF075E4D),
                ),
              ),

              const Spacer(),

              // Percentage - always at the far right
              Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                ),
                child: Text(
                  change,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF15966F),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // ===================================================
          // VALUE
          // ===================================================

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 24,
              height: 1,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 4),

          // ===================================================
          // TITLE
          // ===================================================

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 11.5,
              height: 1.1,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF52635F),
            ),
          ),

          const SizedBox(height: 3),

          // ===================================================
          // SUBTITLE
          // ===================================================

          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 9.5,
              height: 1.1,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF8A9894),
            ),
          ),
        ],
      ),
    );
  }
}