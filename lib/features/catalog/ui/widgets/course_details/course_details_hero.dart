import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        // Course Image / Video Preview
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

        // Best Seller Badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFBFF2DE),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'BEST SELLER',
            style: GoogleFonts.inter(
              fontSize: 8,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF075E4D),
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Course Title
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 20,
            height: 1.25,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 9),

        // Description
        Text(
          description,
          style: GoogleFonts.inter(
            fontSize: 11.5,
            height: 1.5,
            fontWeight: FontWeight.w400,
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
      decoration: BoxDecoration(
        color: const Color(0xFFE4EFEC),
        borderRadius: BorderRadius.circular(16),
      ),
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