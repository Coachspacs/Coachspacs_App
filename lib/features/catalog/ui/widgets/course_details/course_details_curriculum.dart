import 'package:flutter/material.dart';

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
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
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
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
              trailing: const Text(
                'Preview',
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF075E4D),
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}