import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailsHero extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const CourseDetailsHero({
    super.key,
    required this.title,
    required this.description,
    this.imagePath = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =====================================================
        // COURSE IMAGE / INTRO VIDEO PREVIEW
        // =====================================================

        GestureDetector(
          onTap: () {
            _showPreviewDialog(context);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                imagePath.isNotEmpty
                    ? Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 205,
                  fit: BoxFit.cover,
                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return _placeholder();
                  },
                )
                    : _placeholder(),

                // =================================================
                // PLAY BUTTON
                // =================================================

                Positioned.fill(
                  child: Center(
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: 0.92,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.12,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        size: 34,
                        color: Color(0xFF075E4D),
                      ),
                    ),
                  ),
                ),

                // =================================================
                // PREVIEW LABEL
                // =================================================

                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(
                        alpha: 0.55,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.play_circle_outline,
                          size: 15,
                          color: Colors.white,
                        ),

                        const SizedBox(width: 5),

                        Text(
                          'Watch Preview',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // =====================================================
        // BEST SELLER BADGE
        // =====================================================

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFBFF2DE),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'BEST SELLER',
            style: GoogleFonts.inter(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF075E4D),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // =====================================================
        // COURSE TITLE
        // =====================================================

        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 20,
            height: 1.25,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 9),

        // =====================================================
        // DESCRIPTION
        // =====================================================

        Text(
          description,
          style: GoogleFonts.inter(
            fontSize: 11.5,
            height: 1.5,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // PLACEHOLDER
  // ===========================================================

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      height: 205,
      decoration: BoxDecoration(
        color: const Color(0xFFE4EFEC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(
          Icons.play_circle_outline,
          size: 58,
          color: Color(0xFF075E4D),
        ),
      ),
    );
  }

  // ===========================================================
  // INTRO VIDEO PREVIEW
  // ===========================================================

  void _showPreviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Preview icon

                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5F5F0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 30,
                    color: Color(0xFF075E4D),
                  ),
                ),

                const SizedBox(height: 14),

                Text(
                  'Course Preview',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'This is the introductory preview of the course. '
                      'You can watch the preview without signing in.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    height: 1.45,
                    color: const Color(0xFF71807C),
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF075E4D),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(11),
                      ),
                    ),
                    child: Text(
                      'Close Preview',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}