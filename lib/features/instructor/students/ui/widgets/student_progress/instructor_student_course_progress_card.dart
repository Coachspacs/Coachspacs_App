import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/instructor_student_progress.dart';

class InstructorStudentCourseProgressCard
    extends StatelessWidget {
  const InstructorStudentCourseProgressCard({
    super.key,
    required this.student,
  });

  final InstructorStudentProgress student;

  @override
  Widget build(BuildContext context) {
    final progress =
    (student.progress / 100).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // =====================================================
          // COURSE HEADER
          // =====================================================

          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F5F0),
                  borderRadius:
                  BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.menu_book_outlined,
                  size: 21,
                  color: Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.courseName,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        height: 1.25,
                        fontWeight:
                        FontWeight.w800,
                        color:
                        const Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Course Progress',
                      style: GoogleFonts.inter(
                        fontSize: 10.5,
                        color:
                        const Color(0xFF7B8A86),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Text(
                '${student.progress}%',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0A8A6C),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // =====================================================
          // PROGRESS BAR
          // =====================================================

          ClipRRect(
            borderRadius:
            BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 7,
              backgroundColor:
              const Color(0xFFE6EFEC),
              valueColor:
              const AlwaysStoppedAnimation(
                Color(0xFF0A9B78),
              ),
            ),
          ),

          const SizedBox(height: 7),

          Text(
            '${student.completedLessons}/${student.totalLessons} lessons completed',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF7C8B87),
            ),
          ),

          const SizedBox(height: 16),

          // =====================================================
          // ACTIVITY INFO
          // =====================================================

          Row(
            children: [
              Expanded(
                child: _ProgressInfoItem(
                  icon: Icons.access_time_outlined,
                  title: 'Last active',
                  value: student.lastActive,
                ),
              ),

              Container(
                width: 1,
                height: 36,
                color: const Color(0xFFE2EBE8),
              ),

              Expanded(
                child: _ProgressInfoItem(
                  icon: Icons.schedule_outlined,
                  title: 'Time spent',
                  value: student.timeSpent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================
// INFO ITEM
// =============================================================

class _ProgressInfoItem
    extends StatelessWidget {
  const _ProgressInfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF6F2),
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 17,
              color: const Color(0xFF087C64),
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
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    color:
                    const Color(0xFF7C8B87),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight:
                    FontWeight.w700,
                    color:
                    const Color(0xFF263C38),
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