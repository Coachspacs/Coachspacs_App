import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailsInstructor extends StatelessWidget {
  final String instructor;
  final String rating;
  final String students;

  const CourseDetailsInstructor({
    super.key,
    required this.instructor,
    required this.rating,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Instructor Avatar
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFFE4F2EE),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            instructor.trim().isNotEmpty
                ? instructor.trim()[0].toUpperCase()
                : 'T',
            style: GoogleFonts.inter(
              color: const Color(0xFF075E4D),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(width: 9),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // Instructor Name
              Text(
                instructor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF263C38),
                ),
              ),

              const SizedBox(height: 3),

              // Rating + Students
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 13,
                    color: Color(0xFFF2B52E),
                  ),

                  const SizedBox(width: 3),

                  Text(
                    rating,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF263C38),
                    ),
                  ),

                  const SizedBox(width: 5),

                  Text(
                    '($students students)',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF899792),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}