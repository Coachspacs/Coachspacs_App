import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/features/instructor/courses/ui/widgets/create_course/curriculum_lesson_tile.dart';
class CreateCourseCurriculum
    extends StatelessWidget {
  const CreateCourseCurriculum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Curriculum Builder',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Organize your course into sections, lessons and activities.',
          style: GoogleFonts.inter(
            fontSize: 9,
            color: const Color(0xFF788681),
          ),
        ),

        const SizedBox(height: 18),

        // =================================================
        // SECTION 1
        // =================================================

        _CurriculumSection(
          title: 'Introduction & Fundamentals',
          sectionNumber: '01',
          lessons: const [
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

        _CurriculumSection(
          title: 'Core Concepts',
          sectionNumber: '02',
          lessons: const [
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

        const SizedBox(height: 14),

        // =================================================
        // ADD SECTION
        // =================================================

        Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFD3E2DE),
            ),
          ),
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              size: 15,
              color: Color(0xFF075E4D),
            ),
            label: Text(
              'Add New Section',
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color:
                const Color(0xFF075E4D),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================
// SECTION
// =====================================================

class _CurriculumSection
    extends StatelessWidget {
  const _CurriculumSection({
    required this.title,
    required this.sectionNumber,
    required this.lessons,
  });

  final String title;
  final String sectionNumber;
  final List<CurriculumLesson> lessons;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Color(0xFFE4F4EF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  sectionNumber,
                  style: GoogleFonts.inter(
                    fontSize: 7,
                    fontWeight:
                    FontWeight.w700,
                    color:
                    const Color(0xFF075E4D),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight:
                    FontWeight.w700,
                    color:
                    const Color(0xFF263C38),
                  ),
                ),
              ),

              const Icon(
                Icons.more_vert,
                size: 17,
                color: Color(0xFF788681),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ...lessons.map(
                (lesson) => CurriculumLessonTile(
              lesson: lesson,
            ),
          ),

          const SizedBox(height: 4),

          SizedBox(
            width: double.infinity,
            height: 31,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                size: 12,
              ),
              label: Text(
                'Add Lesson',
                style: GoogleFonts.inter(
                  fontSize: 7.5,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
              style: OutlinedButton
                  .styleFrom(
                foregroundColor:
                const Color(
                  0xFF075E4D,
                ),
                side: const BorderSide(
                  color: Color(0xFFD5E4DF),
                ),
                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}