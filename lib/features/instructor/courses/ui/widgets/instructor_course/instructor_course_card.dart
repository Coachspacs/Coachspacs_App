import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/features/instructor/courses/ui/screens/instructor_courses_screen.dart';

class InstructorCourseCard
    extends StatelessWidget {
  const InstructorCourseCard({
    super.key,
    required this.course,
  });

  final InstructorCourse course;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _buildImage(),

          Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              11,
              12,
              12,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                _buildTitle(),

                const SizedBox(height: 7),

                _buildCourseInfo(),

                if (course.rejectionReason !=
                    null) ...[
                  const SizedBox(height: 9),
                  _buildRejectionMessage(),
                ],

                const SizedBox(height: 10),

                _buildActions(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // IMAGE
  // =====================================================

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 1.85,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            course.image,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE5F2EE),
                child: const Center(
                  child: Icon(
                    Icons.menu_book_outlined,
                    size: 38,
                    color: Color(0xFF075E4D),
                  ),
                ),
              );
            },
          ),

          Positioned(
            top: 9,
            right: 9,
            child: _StatusBadge(
              status: course.status,
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // TITLE
  // =====================================================

  Widget _buildTitle() {
    return Text(
      course.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: 12,
        height: 1.25,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF073F38),
      ),
    );
  }

  // =====================================================
  // COURSE INFO
  // =====================================================

  Widget _buildCourseInfo() {
    return Wrap(
      spacing: 10,
      runSpacing: 4,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.people_outline,
              size: 13,
              color: Color(0xFF788681),
            ),
            const SizedBox(width: 4),
            Text(
              '${course.students} students',
              style: GoogleFonts.inter(
                fontSize: 8,
                color: const Color(0xFF788681),
              ),
            ),
          ],
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.payments_outlined,
              size: 13,
              color: Color(0xFF788681),
            ),
            const SizedBox(width: 4),
            Text(
              course.price,
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF52635F),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // =====================================================
  // REJECTION MESSAGE
  // =====================================================

  Widget _buildRejectionMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 14,
            color: Color(0xFFE56A4F),
          ),

          const SizedBox(width: 5),

          Expanded(
            child: Text(
              course.rejectionReason!,
              style: GoogleFonts.inter(
                fontSize: 7.5,
                height: 1.3,
                color: const Color(0xFFB65B48),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // ACTIONS
  // =====================================================

  Widget _buildActions() {
    final isRejected =
        course.status == CourseStatus.rejected;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize:
              const Size(0, 32),
              padding: EdgeInsets.zero,
              side: const BorderSide(
                color: Color(0xFFD6E4E0),
              ),
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Edit Course',
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),
        ),

        const SizedBox(width: 7),

        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize:
              const Size(0, 32),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor:
              const Color(0xFF075E4D),
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(8),
              ),
            ),
            child: Text(
              isRejected
                  ? 'Resubmit'
                  : 'Manage',
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================
// STATUS BADGE
// =====================================================

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
  });

  final CourseStatus status;

  @override
  Widget build(BuildContext context) {
    late String text;
    late Color background;
    late Color foreground;

    switch (status) {
      case CourseStatus.published:
        text = 'Published';
        background = const Color(0xFFDDF3EB);
        foreground = const Color(0xFF075E4D);
        break;

      case CourseStatus.pendingReview:
        text = 'Pending Review';
        background = const Color(0xFFFFF0CF);
        foreground = const Color(0xFF9A6A00);
        break;

      case CourseStatus.draft:
        text = 'Draft';
        background = const Color(0xFFEDEFF0);
        foreground = const Color(0xFF687772);
        break;

      case CourseStatus.rejected:
        text = 'Rejected';
        background = const Color(0xFFFFE5E2);
        foreground = const Color(0xFFC95548);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 6.5,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}