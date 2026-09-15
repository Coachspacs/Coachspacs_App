import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

class MyLearningStats extends StatelessWidget {
  const MyLearningStats({
    super.key,
    required this.enrollments,
  });

  final List<EnrollmentDto> enrollments;

  @override
  Widget build(BuildContext context) {
    final enrolledCount = enrollments.length;

    final completedCount = enrollments
        .where((enrollment) => enrollment.isCompleted)
        .length;

    final activeCount = enrolledCount - completedCount;

    return Column(
      children: [
        // =====================================================
        // TOP STAT CARDS
        // =====================================================
        Row(
          children: [
            Expanded(
              child: _SmallStatCard(
                title: 'ENROLLED',
                value: '$enrolledCount',
                suffix: enrolledCount == 1 ? 'course' : 'courses',
                icon: Icons.menu_book_rounded,
                iconBackground: const Color(0xFFF5F9F7),
                progress: enrolledCount == 0
                    ? 0
                    : (enrolledCount / 5).clamp(0.0, 1.0),
                footerLeft: 'In progress',
                footerRight: '$activeCount active',
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _SmallStatCard(
                title: 'CERTIFICATES',
                value: '$completedCount',
                suffix: 'earned',
                icon: Icons.verified_rounded,
                iconBackground: const Color(0xFFE7F5F0),
                showProgress: false,
                footerLeft: '• Verified credential',
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // =====================================================
        // HOURS STUDIED
        // =====================================================
        const _HoursStudiedCard(),
      ],
    );
  }
}

// =============================================================
// SMALL STAT CARD
// =============================================================

class _SmallStatCard extends StatelessWidget {
  const _SmallStatCard({
    required this.title,
    required this.value,
    required this.suffix,
    required this.icon,
    required this.iconBackground,
    this.progress = 0,
    this.footerLeft,
    this.footerRight,
    this.showProgress = true,
  });

  final String title;
  final String value;
  final String suffix;
  final IconData icon;
  final Color iconBackground;
  final double progress;
  final String? footerLeft;
  final String? footerRight;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.fromLTRB(
        15,
        14,
        15,
        12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE1ECE8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -----------------------------------------------------
          // TITLE + ICON
          // -----------------------------------------------------

          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .5,
                    color: const Color(0xFF82948F),
                  ),
                ),
              ),

              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // -----------------------------------------------------
          // VALUE
          // -----------------------------------------------------

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF073F38),
                  ),
                ),
                TextSpan(
                  text: ' $suffix',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF405B55),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // -----------------------------------------------------
          // PROGRESS
          // -----------------------------------------------------

          if (showProgress) ...[
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 5,
                      backgroundColor:
                      const Color(0xFFE8F0EE),
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(
                        Color(0xFF08715E),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  footerRight ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF245D53),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
          ],

          if (footerLeft != null)
            Text(
              footerLeft!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 9,
                color: const Color(0xFF8A9A96),
              ),
            ),
        ],
      ),
    );
  }
}

// =============================================================
// HOURS STUDIED CARD
// =============================================================

class _HoursStudiedCard extends StatelessWidget {
  const _HoursStudiedCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      // زودنا الارتفاع بشكل آمن
      height: 188,

      padding: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE1ECE8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // HEADER
          // =====================================================

          Row(
            children: [
              Text(
                'HOURS STUDIED',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: .5,
                  color: const Color(0xFF82948F),
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3FBF8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFCBE9DE),
                  ),
                ),
                child: Text(
                  '↗ +4.2h this week',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF176B5C),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 3),

          // =====================================================
          // HOURS VALUE
          // =====================================================

          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '38.5',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF073F38),
                  ),
                ),
                TextSpan(
                  text: ' hrs',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF506862),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          // =====================================================
          // GRAPH + WEEKLY GOAL
          // =====================================================

          SizedBox(
            height: 62,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // -------------------------------------------------
                // GRAPH
                // -------------------------------------------------

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: _StudyGraphPainter(),
                        ),
                      ),

                      const SizedBox(height: 3),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          _DayLabel('MON'),
                          _DayLabel('WED'),
                          _DayLabel('FRI'),
                          _DayLabel('SUN'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // -------------------------------------------------
                // WEEKLY GOAL
                // -------------------------------------------------

                SizedBox(
                  width: 88,
                  height: 42,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F9F7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE1ECE8),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          'WEEKLY GOAL',
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            fontSize: 7.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF8A9A96),
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          '77% (50h)',
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF315B52),
                          ),
                        ),
                      ],
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

// =============================================================
// DAY LABEL
// =============================================================

class _DayLabel extends StatelessWidget {
  const _DayLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 8,
        fontWeight: FontWeight.w500,
        color: const Color(0xFF91A09C),
      ),
    );
  }
}

// =============================================================
// GRAPH
// =============================================================

class _StudyGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF08715E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = const Color(0xFFE9F5F1)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(
      0,
      size.height * .72,
    );

    path.cubicTo(
      size.width * .15,
      size.height * .65,
      size.width * .20,
      size.height * .50,
      size.width * .35,
      size.height * .48,
    );

    path.cubicTo(
      size.width * .50,
      size.height * .45,
      size.width * .53,
      size.height * .75,
      size.width * .68,
      size.height * .32,
    );

    path.cubicTo(
      size.width * .80,
      size.height * .02,
      size.width * .90,
      size.height * .10,
      size.width,
      size.height * .18,
    );

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      fillPath,
      fillPaint,
    );

    canvas.drawPath(
      path,
      linePaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {
    return false;
  }
}