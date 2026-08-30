import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorQuickActions
    extends StatelessWidget {
  const InstructorQuickActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 10),

        Row(
          children: const [
            Expanded(
              child: _ActionCard(
                icon: Icons.add_circle_outline,
                title: 'Create Course',
                subtitle: 'Start teaching',
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: _ActionCard(
                icon: Icons.menu_book_outlined,
                title: 'Manage Courses',
                subtitle: 'View your courses',
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: const [
            Expanded(
              child: _ActionCard(
                icon: Icons.people_outline,
                title: 'Students',
                subtitle: 'View learners',
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: _ActionCard(
                icon: Icons.bar_chart_outlined,
                title: 'Analytics',
                subtitle: 'Track performance',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// =============================================================
// ACTION CARD
// =============================================================

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFE1EAE7),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F5F0),
                  borderRadius:
                  BorderRadius.circular(9),
                ),
                child: Icon(
                  icon,
                  size: 17,
                  color: const Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 9.5,
                        fontWeight:
                        FontWeight.w700,
                        color:
                        const Color(0xFF263C38),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 7,
                        color:
                        const Color(0xFF84918D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}