import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorEditCourseCurriculum extends StatelessWidget {
  const InstructorEditCourseCurriculum({
    super.key,
    required this.onEdit,
  });

  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    const sections = [
      ('01', 'Introduction', '3 lessons'),
      ('02', 'React 19 Essentials', '8 lessons'),
      ('03', 'Next.js App Router Basics', '7 lessons'),
      ('04', 'Data Fetching & Mutations', '9 lessons'),
    ];

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
        children: [
          Row(
            children: [
              _IconBox(
                icon: Icons.video_library_outlined,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Curriculum',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF073F38),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Manage sections and lessons.',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        color: const Color(0xFF84928E),
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: onEdit,
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: Color(0xFF075E4D),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...sections.map(
                (section) => Container(
              margin: const EdgeInsets.only(bottom: 9),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 11,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAF9),
                borderRadius: BorderRadius.circular(11),
                border: Border.all(
                  color: const Color(0xFFE3ECE9),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.drag_indicator_rounded,
                    size: 19,
                    color: Color(0xFF9AAEA8),
                  ),

                  const SizedBox(width: 6),

                  Container(
                    width: 29,
                    height: 29,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4F1ED),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      section.$1,
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF075E4D),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          section.$2,
                          style: GoogleFonts.inter(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF073F38),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          section.$3,
                          style: GoogleFonts.inter(
                            fontSize: 8.5,
                            color: const Color(0xFF899792),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 19,
                    color: Color(0xFF91A39E),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 4),

          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton.icon(
              onPressed: onEdit,
              icon: const Icon(
                Icons.edit_outlined,
                size: 16,
              ),
              label: Text(
                'Edit Curriculum',
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF075E4D),
                side: const BorderSide(
                  color: Color(0xFFC8DAD5),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        size: 19,
        color: const Color(0xFF075E4D),
      ),
    );
  }
}