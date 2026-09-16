import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/curriculum_lesson_tile.dart';

class CreateCourseCurriculum extends StatelessWidget {
  const CreateCourseCurriculum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =================================================
        // TITLE
        // =================================================

        Text(
          'Curriculum Builder',
          style: GoogleFonts.inter(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Organize your course into sections, lessons and activities.',
          style: GoogleFonts.inter(
            fontSize: 11.5,
            height: 1.4,
            color: const Color(0xFF788681),
          ),
        ),

        const SizedBox(height: 16),

        // =================================================
        // SECTION 1
        // =================================================

        const _CurriculumSection(
          sectionNumber: '01',
          title: 'Introduction & Fundamentals',
          lessons: [
            CurriculumLesson(
              title: 'Welcome to the Course',
              type: 'Video',
              duration: '2:46',
            ),
            CurriculumLesson(
              title: 'Course Syllabus & Goals',
              type: 'Text',
              duration: '',
            ),
          ],
        ),

        const SizedBox(height: 12),

        // =================================================
        // SECTION 2
        // =================================================

        const _CurriculumSection(
          sectionNumber: '02',
          title: 'Core Concepts',
          lessons: [
            CurriculumLesson(
              title: 'Understanding the Framework',
              type: 'Video',
              duration: '15:30',
            ),
            CurriculumLesson(
              title: 'Knowledge Check',
              type: 'Quiz',
              duration: '',
            ),
          ],
        ),

        const SizedBox(height: 12),

        // =================================================
        // ADD SECTION
        // =================================================

        _AddSectionButton(
          onPressed: () {},
        ),
      ],
    );
  }
}

// =====================================================
// CURRICULUM SECTION
// =====================================================

class _CurriculumSection extends StatelessWidget {
  const _CurriculumSection({
    required this.sectionNumber,
    required this.title,
    required this.lessons,
  });

  final String sectionNumber;
  final String title;
  final List<CurriculumLesson> lessons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =============================================
          // SECTION HEADER
          // =============================================

          Row(
            children: [
              // Drag
              const Icon(
                Icons.drag_indicator_rounded,
                size: 14,
                color: Color(0xFFA2B1AD),
              ),

              const SizedBox(width: 3),

              // Number
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFFE4F4EF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  sectionNumber,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF075E4D),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(

                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF263C38),
                  ),
                ),
              ),

              // Edit
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 13,
                  color: Color(0xFF8A9995),
                ),
              ),

              // Delete
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 13,
                  color: Color(0xFF8A9995),
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          // =============================================
          // LESSONS
          // =============================================

          ...lessons.map(
                (lesson) => CurriculumLessonTile(
              lesson: lesson,
            ),
          ),

          const SizedBox(height: 2),

          // =============================================
          // ADD LESSON
          // =============================================

          SizedBox(
            width: double.infinity,
            height: 32,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                size: 12,
              ),
              label: Text(
                'Add Lesson',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor:
                const Color(0xFF075E4D),
                side: const BorderSide(
                  color: Color(0xFFD5E4DF),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// ADD SECTION
// =====================================================

class _AddSectionButton extends StatelessWidget {
  const _AddSectionButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.add,
          size: 15,
        ),
        label: Text(
          'Add New Section',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF075E4D),
          backgroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFFD3E2DE),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}