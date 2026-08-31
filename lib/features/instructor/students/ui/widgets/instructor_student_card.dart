import 'package:flutter/material.dart';

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
                    fontSize: 11,
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
                        fontSize: 13,
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
                        fontSize: 9.5,
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

          Row(
            children: [
              const Text(
                'Progress',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7A8985),
                ),
              ),

              const Spacer(),

              Text(
                '$progress%',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: progressColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          ClipRRect(
            borderRadius:
            BorderRadius.circular(20),
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
                  fontSize: 8.5,
                  color: Color(0xFF899792),
                ),
              ),

              const Spacer(),

              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4F0),
                  borderRadius:
                  BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: Color(0xFF075E4D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
          fontSize: 8,
          fontWeight: FontWeight.w700,
          color: foreground,
        ),
      ),
    );
  }
}