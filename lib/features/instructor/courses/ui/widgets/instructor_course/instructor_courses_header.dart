import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorCoursesHeader
    extends StatelessWidget {
  const InstructorCoursesHeader({
    super.key,
    required this.onCreateCourse,
  });

  final VoidCallback onCreateCourse;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'My Courses',
                style: GoogleFonts.inter(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color:
                  const Color(0xFF073F38),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                'Manage your published, pending and draft courses.',
                maxLines: 2,
                overflow:
                TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  color:
                  const Color(0xFF788681),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        SizedBox(
          height: 36,
          child: ElevatedButton.icon(
            onPressed: onCreateCourse,
            icon: const Icon(
              Icons.add,
              size: 14,
            ),
            label: Text(
              'New Course',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            style:
            ElevatedButton.styleFrom(
              backgroundColor:
              const Color(0xFF075E4D),
              foregroundColor: Colors.white,
              elevation: 0,
              padding:
              const EdgeInsets.symmetric(
                horizontal: 11,
              ),
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}