import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailsInstructorCard extends StatelessWidget {
  final String instructor;

  const CourseDetailsInstructorCard({
    super.key,
    required this.instructor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Row(
        children: [
          // Instructor Avatar
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFFE4F2EE),
            child: Text(
              instructor.trim().isNotEmpty
                  ? instructor.trim()[0].toUpperCase()
                  : 'T',
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  instructor,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF263C38),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Experienced instructor and professional educator.',
                  style: GoogleFonts.inter(
                    fontSize: 10,
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
}