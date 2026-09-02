import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailsCurriculum extends StatelessWidget {
  const CourseDetailsCurriculum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _CurriculumSection(
          title: 'Section 1: Getting Started',
          lessons: [
            'Introduction to Modern UI Patterns',
            'Setting up your development workspace',
            'Understanding Design Tokens & Components',
          ],
        ),
        _CurriculumSection(
          title: 'Section 2: Core Concepts & Layout Architecture',
          lessons: [
            'Component Architecture',
            'Responsive Layouts',
            'Reusable UI Components',
          ],
        ),
        _CurriculumSection(
          title: 'Section 3: Building a Real Project',
          lessons: [
            'Project Structure',
            'Advanced Interactions',
            'Micro-interactions',
          ],
        ),
      ],
    );
  }
}

class _CurriculumSection extends StatelessWidget {
  final String title;
  final List<String> lessons;

  const _CurriculumSection({
    required this.title,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 13,
        ),
        childrenPadding: const EdgeInsets.only(
          bottom: 5,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        collapsedShape:
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF263C38),
          ),
        ),
        children: lessons.map(
              (lesson) {
            return ListTile(
              dense: true,
              leading: const Icon(
                Icons.play_circle_outline,
                size: 17,
                color: Color(0xFF075E4D),
              ),
              title: Text(
                lesson,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF53645F),
                ),
              ),
              trailing: Text(
                'Preview',
                style: GoogleFonts.inter(
                  fontSize: 8.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF075E4D),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}