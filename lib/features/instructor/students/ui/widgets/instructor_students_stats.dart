import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorStudentsStats extends StatelessWidget {
  const InstructorStudentsStats({
    super.key,
  });

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

      children: const [
        _StudentStatCard(
          icon: Icons.people_alt_outlined,
          value: '1,240',
          title: 'Total Students',
          change: '+12%',
          subtitle: 'vs last month',
        ),

        _StudentStatCard(
          icon: Icons.bolt_outlined,
          value: '956',
          title: 'Active Students',
          change: '+8%',
          subtitle: 'vs last month',
        ),

        _StudentStatCard(
          icon: Icons.verified_outlined,
          value: '642',
          title: 'Completed',
          change: '+15%',
          subtitle: 'vs last month',
        ),

        _StudentStatCard(
          icon: Icons.pie_chart_outline_rounded,
          value: '78%',
          title: 'Avg Completion',
          change: '+8%',
          subtitle: 'vs last month',
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