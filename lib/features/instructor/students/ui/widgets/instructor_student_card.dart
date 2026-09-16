import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/features/instructor/students/data/models/instructor_student_progress.dart';

class InstructorStudentCard extends StatelessWidget {
  const InstructorStudentCard({
    super.key,
    required this.student,
  });

  final dynamic student;

  @override
  Widget build(BuildContext context) {
    final int progress = student.progress;

    final Color progressColor =
    progress >= 70
        ? const Color(0xFF15966F)
        : progress >= 40
        ? const Color(0xFFE5A51D)
        : const Color(0xFFE05252);

    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFDDE8E5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // =====================================================
          // STUDENT HEADER
          // =====================================================

          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFFE4F4EF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  student.initials,
                  style: const TextStyle(

                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF075E4D),
                  ),
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF173D37),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      student.course,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF788681),
                      ),
                    ),
                  ],
                ),
              ),

              _buildStatus(student.status),
            ],
          ),

          const SizedBox(height: 13),

          // =====================================================
          // PROGRESS
          // =====================================================

          Row(
            children: [
              const Text(
                'Progress',
                style: TextStyle(

                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7A8985),
                ),
              ),

              const Spacer(),

              Text(
                '$progress%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: progressColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 6,
              backgroundColor:
              const Color(0xFFEAF0EE),
              valueColor:
              AlwaysStoppedAnimation<Color>(
                progressColor,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // =====================================================
          // LAST ACTIVE + DETAILS
          // =====================================================

          Row(
            children: [
              const Icon(
                Icons.access_time_rounded,
                size: 12,
                color: Color(0xFF9AA7A3),
              ),

              const SizedBox(width: 4),

              Text(
                'Last active ${student.lastActive}',
                style: const TextStyle(
                  fontSize: 10.5,
                  color: Color(0xFF899792),
                ),
              ),

              const Spacer(),

              // =================================================
              // STUDENT DETAILS BUTTON
              // =================================================

              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    final progressData =
                    InstructorStudentProgress(
                      name: student.name,
                      initials: student.initials,
                      courseName: student.course,
                      progress: student.progress,

                      // Temporary values until the
                      // students API provides them.
                      completedLessons:
                      student.progress == 100 ? 20 : 17,
                      totalLessons: 20,

                      status: student.status,
                      enrolledDate: 'Oct 12, 2024',
                      lastActive: student.lastActive,
                      timeSpent: '18h 45m',

                      quizScores: const [
                        InstructorStudentQuizScore(
                          title:
                          'Module 1: Clean Architecture',
                          score: 95,
                        ),
                        InstructorStudentQuizScore(
                          title:
                          'Module 2: State Management',
                          score: 88,
                        ),
                      ],
                    );

                    Navigator.pushNamed(
                      context,
                      AppRoutes.instructorStudentProgress,
                      arguments: progressData,
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F4F0),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: Color(0xFF075E4D),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // STATUS
  // =====================================================

  Widget _buildStatus(String status) {
    Color background;
    Color foreground;

    switch (status) {
      case 'Completed':
        background = const Color(0xFFEAF2FF);
        foreground = const Color(0xFF3972B8);
        break;

      case 'Inactive':
        background = const Color(0xFFFFEEEE);
        foreground = const Color(0xFFD34F4F);
        break;

      default:
        background = const Color(0xFFE4F7EF);
        foreground = const Color(0xFF15966F);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}