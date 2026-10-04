import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Page title block for the instructor students screen.
class StudentsPageTitle extends StatelessWidget {
  const StudentsPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        16,
        18,
        6,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  'Enrolled Students',
                  style: GoogleFonts.inter(
                    fontSize: 23,
                    height: 1.1,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                    letterSpacing: -0.3,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Manage and track your students',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF788681),
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
