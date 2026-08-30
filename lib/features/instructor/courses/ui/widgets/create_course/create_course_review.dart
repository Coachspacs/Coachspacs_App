import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCourseReview
    extends StatelessWidget {
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
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          'Review & Publish',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Check everything one last time before submitting your course.',
          style: GoogleFonts.inter(
            fontSize: 9,
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
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 105,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFFE6F1EE),
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.image_outlined,
                  size: 30,
                  color:
                  Color(0xFF075E4D),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                title,
                maxLines: 2,
                overflow:
                TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  const Color(0xFF263C38),
                ),
              ),

              const SizedBox(height: 5),

              Text(
                description.isEmpty
                    ? 'Learn practical skills and build confidence through this complete course.'
                    : description,
                maxLines: 3,
                overflow:
                TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 8,
                  height: 1.4,
                  color:
                  const Color(0xFF788681),
                ),
              ),

              const SizedBox(height: 9),

              Wrap(
                spacing: 6,
                runSpacing: 5,
                children: [
                  _InfoChip(
                    text: category,
                  ),
                  _InfoChip(
                    text: level,
                  ),
                  _InfoChip(
                    text: language,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // =================================================
        // PRICE
        // =================================================

        _ReviewCard(
          title: 'Course Price',
          icon: Icons.payments_outlined,
          child: Text(
            price,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color:
              const Color(0xFF073F38),
            ),
          ),
        ),

        const SizedBox(height: 14),

        // =================================================
        // CURRICULUM
        // =================================================

        _ReviewCard(
          title: 'Curriculum Overview',
          icon: Icons.library_books_outlined,
          child: Column(
            children: const [
              _ReviewLesson(
                number: '01',
                title:
                'The Foundations of Influence',
                subtitle:
                '3 lessons • 45 min',
              ),
              _ReviewLesson(
                number: '02',
                title:
                'Navigating Difficult Conversations',
                subtitle:
                '4 lessons • 1 hr 10 min',
              ),
              _ReviewLesson(
                number: '03',
                title:
                'Public Speaking for Leaders',
                subtitle:
                '2 lessons • 32 min',
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // =================================================
        // WHAT HAPPENS NEXT
        // =================================================

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFDDF3EB),
            borderRadius:
            BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                size: 17,
                color:
                Color(0xFF075E4D),
              ),

              const SizedBox(width: 7),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What happens next?',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight:
                        FontWeight.w700,
                        color:
                        const Color(
                          0xFF075E4D,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Your course will be sent to our team for review. You will be notified once it has been approved.',
                      style: GoogleFonts.inter(
                        fontSize: 7.5,
                        height: 1.4,
                        color:
                        const Color(
                          0xFF4B6D64,
                        ),
                      ),
                    ),
                  ],
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
// REVIEW CARD
// =====================================================

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 15,
                color:
                const Color(0xFF075E4D),
              ),

              const SizedBox(width: 6),

              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight:
                  FontWeight.w700,
                  color:
                  const Color(0xFF263C38),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          child,
        ],
      ),
    );
  }
}

// =====================================================
// INFO CHIP
// =====================================================

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F5F0),
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 7,
          fontWeight:
          FontWeight.w600,
          color:
          const Color(0xFF075E4D),
        ),
      ),
    );
  }
}

// =====================================================
// REVIEW LESSON
// =====================================================

class _ReviewLesson
    extends StatelessWidget {
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
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 9),
      child: Row(
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
              number,
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
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 8.5,
                    fontWeight:
                    FontWeight.w700,
                    color:
                    const Color(
                      0xFF354640,
                    ),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 7,
                    color:
                    const Color(
                      0xFF899792,
                    ),
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