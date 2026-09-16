import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCourseReview extends StatelessWidget {
  const CreateCourseReview({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.level,
    required this.language,
    required this.price,
  });

  final String title;
  final String description;
  final String category;
  final String level;
  final String language;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =================================================
        // TITLE
        // =================================================

        Text(
          'Review & Publish',
          style: GoogleFonts.inter(
            fontSize: 21,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Check everything one last time before submitting your course.',
          style: GoogleFonts.inter(
            fontSize: 11.5,
            height: 1.4,
            color: const Color(0xFF788681),
          ),
        ),

        const SizedBox(height: 18),

        // =================================================
        // COURSE BASICS
        // =================================================

        _ReviewCard(
          title: 'Course Basics',
          icon: Icons.menu_book_outlined,
          actionText: 'Edit',
          onAction: () {},
          child: _CourseBasicPreview(
            title: title,
            description: description,
            category: category,
            level: level,
            language: language,
          ),
        ),

        const SizedBox(height: 14),

        // =================================================
        // COURSE PRICE
        // =================================================

        _PriceRow(
          price: price,
        ),

        const SizedBox(height: 14),

        // =================================================
        // CURRICULUM
        // =================================================

        _ReviewCard(
          title: 'Curriculum Overview',
          icon: Icons.layers_outlined,
          actionText: 'Edit',
          onAction: () {},
          child: const _CurriculumOverview(),
        ),

        const SizedBox(height: 14),

        // =================================================
        // WHAT HAPPENS NEXT
        // =================================================

        const _WhatHappensNext(),
      ],
    );
  }
}

// =====================================================
// REVIEW CARD
// =====================================================

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.title,
    required this.icon,
    required this.child,
    this.actionText,
    this.onAction,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
          // HEADER
          // =============================================

          Row(
            children: [
              Icon(
                icon,
                size: 15,
                color: const Color(0xFF075E4D),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF263C38),
                  ),
                ),
              ),

              if (actionText != null)
                GestureDetector(
                  onTap: onAction,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit_outlined,
                        size: 11,
                        color: Color(0xFF075E4D),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        actionText!,
                        style: GoogleFonts.inter(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF075E4D),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 9),

          const Divider(
            height: 1,
            color: Color(0xFFE8EEEC),
          ),

          const SizedBox(height: 10),

          child,
        ],
      ),
    );
  }
}

// =====================================================
// COURSE BASIC PREVIEW
// =====================================================

class _CourseBasicPreview extends StatelessWidget {
  const _CourseBasicPreview({
    required this.title,
    required this.description,
    required this.category,
    required this.level,
    required this.language,
  });

  final String title;
  final String description;
  final String category;
  final String level;
  final String language;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =============================================
        // COURSE IMAGE PLACEHOLDER
        // =============================================

        Container(
          width: 62,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFE5F3EF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.image_outlined,
            size: 24,
            color: Color(0xFF6C9990),
          ),
        ),

        const SizedBox(width: 10),

        // =============================================
        // DETAILS
        // =============================================

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF263C38),
                ),
              ),

              const SizedBox(height: 4),

              if (description.isNotEmpty)
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    height: 1.35,
                    color: const Color(0xFF788681),
                  ),
                ),

              const SizedBox(height: 6),

              Wrap(
                spacing: 5,
                runSpacing: 4,
                children: [
                  _SmallTag(
                    text: category,
                  ),
                  _SmallTag(
                    text: level,
                  ),
                  _SmallTag(
                    text: language,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// SMALL TAG
// =====================================================

class _SmallTag extends StatelessWidget {
  const _SmallTag({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF6F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.inter(
          fontSize: 8.5,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF075E4D),
        ),
      ),
    );
  }
}

// =====================================================
// PRICE
// =====================================================

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.price,
  });

  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Course Price',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF667570),
            ),
          ),

          const Spacer(),

          Text(
            price,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// CURRICULUM OVERVIEW
// =====================================================

class _CurriculumOverview
    extends StatelessWidget {
  const _CurriculumOverview();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ReviewLesson(
          number: '01',
          title: 'The Foundations of Influence',
          subtitle: '3 lessons • 45 min',
        ),
        SizedBox(height: 7),
        _ReviewLesson(
          number: '02',
          title: 'Navigating Difficult Conversations',
          subtitle: '4 lessons • 1 hr 15 min',
        ),
        SizedBox(height: 7),
        _ReviewLesson(
          number: '03',
          title: 'Public Speaking for Leaders',
          subtitle: '5 lessons • 2 hr 30 min',
        ),
      ],
    );
  }
}

// =====================================================
// REVIEW LESSON
// =====================================================

class _ReviewLesson extends StatelessWidget {
  const _ReviewLesson({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 23,
          height: 23,
          decoration: const BoxDecoration(
            color: Color(0xFFE6F5F1),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF075E4D),
            ),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF263C38),
                ),
              ),

              const SizedBox(height: 2),

              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 8.5,
                  color: const Color(0xFF788681),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================
// WHAT HAPPENS NEXT
// =====================================================

class _WhatHappensNext extends StatelessWidget {
  const _WhatHappensNext();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFC6E8E1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline_rounded,
              size: 14,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'What happens next?',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF075E4D),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  'Your course will be sent to our team for review. '
                      'We usually review courses within 1–2 business days.',
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    height: 1.4,
                    color: const Color(0xFF55736C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}