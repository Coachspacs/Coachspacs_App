import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

class CourseDetailsInstructorCard extends StatelessWidget {
  final String instructor;
  final String avatar;

  const CourseDetailsInstructorCard({
    super.key,
    required this.instructor,
    this.avatar = '',
  });

  @override
  Widget build(BuildContext context) {
    final url = avatar.trim();

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE8E4)),
      ),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox(
              width: 50,
              height: 50,
              child: url.isEmpty
                  ? _initial()
                  : Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _initial(),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF263C38),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.l10n.courseDetailsInstructorBio,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF71827E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _initial() {
    return Container(
      color: const Color(0xFFE4F2EE),
      alignment: Alignment.center,
      child: Text(
        instructor.trim().isNotEmpty
            ? instructor.trim()[0].toUpperCase()
            : '?',
        style: GoogleFonts.inter(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF075E4D),
        ),
      ),
    );
  }
}
