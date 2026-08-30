import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =====================================================
// CURRICULUM LESSON MODEL
// =====================================================

class CurriculumLesson {
  const CurriculumLesson({
    required this.title,
    required this.type,
    required this.duration,
  });

  final String title;
  final String type;
  final String duration;
}

// =====================================================
// CURRICULUM LESSON TILE
// =====================================================

class CurriculumLessonTile extends StatelessWidget {
  const CurriculumLessonTile({
    super.key,
    required this.lesson,
  });

  final CurriculumLesson lesson;

  @override
  Widget build(BuildContext context) {
    final IconData lessonIcon;
    final Color iconColor;

    switch (lesson.type) {
      case 'Quiz':
        lessonIcon = Icons.quiz_outlined;
        iconColor = const Color(0xFF9A6A00);
        break;

      case 'Text':
        lessonIcon = Icons.article_outlined;
        iconColor = const Color(0xFF075E4D);
        break;

      default:
        lessonIcon = Icons.play_circle_outline;
        iconColor = const Color(0xFF075E4D);
    }

    return Container(
      margin: const EdgeInsets.only(
        bottom: 6,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAF9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE1EAE7),
        ),
      ),
      child: Row(
        children: [
          // =================================================
          // DRAG HANDLE
          // =================================================

          const Icon(
            Icons.drag_indicator,
            size: 14,
            color: Color(0xFF9AA7A3),
          ),

          const SizedBox(width: 4),

          // =================================================
          // LESSON ICON
          // =================================================

          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFFE4F4EF),
              borderRadius: BorderRadius.circular(7),
            ),
            alignment: Alignment.center,
            child: Icon(
              lessonIcon,
              size: 13,
              color: iconColor,
            ),
          ),

          const SizedBox(width: 8),

          // =================================================
          // LESSON INFO
          // =================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF354640),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  lesson.type,
                  style: GoogleFonts.inter(
                    fontSize: 7,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF899792),
                  ),
                ),
              ],
            ),
          ),

          // =================================================
          // DURATION / TYPE
          // =================================================

          if (lesson.duration.isNotEmpty)
            Text(
              lesson.duration,
              style: GoogleFonts.inter(
                fontSize: 7,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF899792),
              ),
            ),

          if (lesson.type == 'Quiz')
            Container(
              margin: const EdgeInsets.only(
                left: 6,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3D6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Quiz',
                style: GoogleFonts.inter(
                  fontSize: 6.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF9A6A00),
                ),
              ),
            ),
        ],
      ),
    );
  }
}