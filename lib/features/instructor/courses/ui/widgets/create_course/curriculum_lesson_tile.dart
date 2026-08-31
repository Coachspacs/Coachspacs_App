import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

class CurriculumLessonTile extends StatelessWidget {
  const CurriculumLessonTile({
    super.key,
    required this.lesson,
  });

  final CurriculumLesson lesson;

  @override
  Widget build(BuildContext context) {
    final bool isVideo = lesson.type == 'Video';
    final bool isQuiz = lesson.type == 'Quiz';

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBFA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE0EAE7),
        ),
      ),
      child: Row(
        children: [
          // =================================================
          // DRAG HANDLE
          // =================================================

          const Icon(
            Icons.drag_indicator_rounded,
            size: 14,
            color: Color(0xFFA2B1AD),
          ),

          const SizedBox(width: 5),

          // =================================================
          // TYPE ICON
          // =================================================

          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isQuiz
                  ? const Color(0xFFFFF2D9)
                  : const Color(0xFFE5F5F0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isQuiz
                  ? Icons.quiz_outlined
                  : isVideo
                  ? Icons.play_arrow_rounded
                  : Icons.article_outlined,
              size: 13,
              color: isQuiz
                  ? const Color(0xFFB87900)
                  : const Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 8),

          // =================================================
          // LESSON TITLE
          // =================================================

          Expanded(
            child: Text(
              lesson.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF263C38),
              ),
            ),
          ),

          const SizedBox(width: 6),

          // =================================================
          // TYPE / DURATION
          // =================================================

          if (lesson.duration.isNotEmpty)
            Text(
              lesson.duration,
              style: GoogleFonts.inter(
                fontSize: 7,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF7A8985),
              ),
            )
          else
            Text(
              lesson.type,
              style: GoogleFonts.inter(
                fontSize: 7,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF7A8985),
              ),
            ),

          const SizedBox(width: 5),

          // =================================================
          // MORE
          // =================================================

          const Icon(
            Icons.more_vert,
            size: 14,
            color: Color(0xFF9AA8A4),
          ),
        ],
      ),
    );
  }
}