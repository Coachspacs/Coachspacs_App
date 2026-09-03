import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';

class InstructorCourseSummaryCard extends StatelessWidget {
  const InstructorCourseSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 86,
            height: 82,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2EF),
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              'assets/images/course1.png',
              fit: BoxFit.cover,
              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {
                return const Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF075E4D),
                  size: 30,
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2F5EF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'PUBLISHED',
                    style: GoogleFonts.inter(
                      fontSize: 6.5,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF218066),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'React 19 & Next.js App Router Masterclass',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.25,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF173D37),
                  ),
                ),

                const SizedBox(height: 7),

                Row(
                  children: [
                    const Icon(
                      Icons.people_outline_rounded,
                      size: 13,
                      color: Color(0xFF82918D),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '350 students',
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        color: const Color(0xFF71807C),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Icon(
                      Icons.menu_book_outlined,
                      size: 13,
                      color: Color(0xFF82918D),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '42 lessons',
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        color: const Color(0xFF71807C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

      IconButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.instructorCourseEdit,
            arguments: {
              'title':
              'React 19 & Next.js App Router Masterclass',
              'description':
              'Master React 19 and Next.js App Router.',
              'category': 'Development',
              'level': 'Intermediate',
              'language': 'English',
              'price': '\$49.00',
            },
          );
        },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minWidth: 32,
          minHeight: 32,
        ),
        icon: const Icon(
          Icons.edit_outlined,
          size: 17,
          color: Color(0xFF667570),
        ),
        ),
        ],
      ),
    );
  }
}