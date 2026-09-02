import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),
        const SizedBox(height: 10),

        const _ActivityItem(
          icon: Icons.check_circle_outline,
          title: 'Completed Lesson 11',
          subtitle: 'React 19 & Next.js',
          time: '2 hours ago',
        ),

        const _ActivityItem(
          icon: Icons.play_circle_outline,
          title: 'Started Lesson 12',
          subtitle: 'Advanced State Management',
          time: 'Yesterday',
        ),

        const _ActivityItem(
          icon: Icons.workspace_premium_outlined,
          title: 'Earned a certificate',
          subtitle: 'Full-Stack Development',
          time: '3 days ago',
        ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Color(0xFFE5F4EF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 17,
              color: const Color(0xFF075E4D),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF263C38),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: const Color(0xFF71807C),
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 8,
              color: const Color(0xFF899792),
            ),
          ),
        ],
      ),
    );
  }
}