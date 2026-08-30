import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailsIncludes extends StatelessWidget {
  const CourseDetailsIncludes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _IncludeItem(
          icon: Icons.ondemand_video_outlined,
          text: '12 hours of video lessons',
        ),
        _IncludeItem(
          icon: Icons.description_outlined,
          text: 'Downloadable resources',
        ),
        _IncludeItem(
          icon: Icons.code_outlined,
          text: 'Practical projects and exercises',
        ),
        _IncludeItem(
          icon: Icons.access_time,
          text: 'Lifetime access',
        ),
        _IncludeItem(
          icon: Icons.workspace_premium_outlined,
          text: 'Certificate of completion',
        ),
      ],
    );
  }
}

class _IncludeItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _IncludeItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          // Feature Icon
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: const Color(0xFFE5F4EF),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 15,
              color: const Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 9),

          // Feature Text
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF52635F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}