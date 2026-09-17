import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorStatsGrid extends StatelessWidget {
  const InstructorStatsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Responsive card height.
        final cardHeight = width < 360
            ? 92.0
            : width < 500
            ? 96.0
            : 104.0;

        return GridView.builder(
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          itemCount: _stats.length,

          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: cardHeight,
          ),

          itemBuilder: (context, index) {
            final stat = _stats[index];

            return _StatCard(
              icon: stat.icon,
              value: stat.value,
              label: stat.label,
              trend: stat.trend,
            );
          },
        );
      },
    );
  }
}

// =============================================================
// MOCK STATS
// =============================================================

const List<_StatData> _stats = [
  _StatData(
    icon: Icons.menu_book_outlined,
    value: '12',
    label: 'Total Courses',
    trend: '+2 this month',
  ),

  _StatData(
    icon: Icons.pending_actions_outlined,
    value: '2',
    label: 'Under Review',
    trend: 'Needs attention',
  ),

  _StatData(
    icon: Icons.edit_note_outlined,
    value: '3',
    label: 'Drafts',
    trend: 'In progress',
  ),

  _StatData(
    icon: Icons.people_outline,
    value: '2,240',
    label: 'Total Students',
    trend: '+18.4%',
  ),
];

// =============================================================
// STAT DATA
// =============================================================

class _StatData {
  const _StatData({
    required this.icon,
    required this.value,
    required this.label,
    required this.trend,
  });

  final IconData icon;
  final String value;
  final String label;
  final String trend;
}

// =============================================================
// STAT CARD
// =============================================================

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.trend,
  });

  final IconData icon;
  final String value;
  final String label;
  final String trend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        11,
        10,
        11,
        9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE1EAE7),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // ===================================================
          // TOP ROW
          // ===================================================

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F5F0),
                  borderRadius:
                  BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 15,
                  color:
                  const Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  trend,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  textAlign:
                  TextAlign.right,
                  style: GoogleFonts.inter(
                    fontSize: 7,
                    fontWeight:
                    FontWeight.w600,
                    color:
                    const Color(0xFF4B8D7D),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // ===================================================
          // VALUE
          // ===================================================

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment:
            Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: GoogleFonts.inter(
                fontSize: 19,
                fontWeight:
                FontWeight.w800,
                color:
                const Color(0xFF073F38),
              ),
            ),
          ),

          const SizedBox(height: 1),

          // ===================================================
          // LABEL
          // ===================================================

          Text(
            label,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 10.5,
              fontWeight:
              FontWeight.w500,
              color:
              const Color(0xFF788681),
            ),
          ),
        ],
      ),
    );
  }
}