import 'package:flutter/material.dart';

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
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: imagePath.isNotEmpty
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
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFBFF2DE),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'BEST SELLER',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w900,
              color: Color(0xFF075E4D),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            height: 1.2,
            fontWeight: FontWeight.w900,
            color: Color(0xFF073F38),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            height: 1.5,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      height: 205,
      color: const Color(0xFFE4EFEC),
      child: const Center(
        child: Icon(
          Icons.play_circle_outline,
          size: 58,
          color: Color(0xFF075E4D),
        ),
      ),
    );
  }
}