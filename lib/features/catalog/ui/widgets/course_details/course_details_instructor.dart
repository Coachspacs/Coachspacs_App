import 'package:flutter/material.dart';

class CourseDetailsInstructor extends StatelessWidget {
  final String instructor;
  final String rating;
  final String students;

  const CourseDetailsInstructor({
    super.key,
    required this.instructor,
    required this.rating,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: const BoxDecoration(
            color: Color(0xFFE4F2EE),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'T',
            style: TextStyle(
              color: Color(0xFF075E4D),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                instructor,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 13,
                    color: Color(0xFFF2B52E),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    rating,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '($students students)',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey.shade500,
                    ),
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