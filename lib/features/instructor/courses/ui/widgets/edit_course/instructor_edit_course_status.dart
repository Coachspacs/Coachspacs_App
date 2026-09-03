import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorEditCourseStatus extends StatelessWidget {
  const InstructorEditCourseStatus({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final bool isPublished =
        status.toLowerCase() == 'published';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0EAE7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.check_circle_outline_rounded,
                  size: 19,
                  color: Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    'Course Status',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF073F38),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Current publication status.',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: const Color(0xFF84928E),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isPublished
                  ? const Color(0xFFF0F8F5)
                  : const Color(0xFFFFF7E5),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Row(
              children: [
                Icon(
                  isPublished
                      ? Icons.check_circle_rounded
                      : Icons.pending_outlined,
                  size: 20,
                  color: isPublished
                      ? const Color(0xFF075E4D)
                      : const Color(0xFFA16F00),
                ),

                const SizedBox(width: 9),

                Expanded(
                  child: Text(
                    isPublished
                        ? 'This course is currently published.'
                        : 'This course is currently under review.',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF344540),
                    ),
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