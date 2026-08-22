import 'package:flutter/material.dart';

class CourseDetailsInstructorCard extends StatelessWidget {
  final String instructor;

  const CourseDetailsInstructorCard({
    super.key,
    required this.instructor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFFE4F2EE),
            child: Text(
              'T',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF075E4D),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instructor,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Experienced instructor and professional educator.',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF71827E),
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