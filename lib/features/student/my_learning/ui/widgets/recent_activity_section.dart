import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 10),

        const _ActivityItem(
          icon: Icons.check_circle_outline_rounded,
          title: 'Completed Lesson 11',
          subtitle: 'React 19 & Next.js',
          time: '2 hours ago',
        ),

        const _ActivityItem(
          icon: Icons.play_circle_outline_rounded,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE0ECE8),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE5F5F0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 19,
              color: const Color(0xFF08715E),
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF173E37),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: const Color(0xFF91A09C),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 8.5,
              color: const Color(0xFF8A9A96),
            ),
          ),
        ],
      ),
    );
  }
}