import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/media_url.dart';

class CourseDetailsInstructor extends StatelessWidget {
  final String instructor;
  final String avatar;

  const CourseDetailsInstructor({
    super.key,
    required this.instructor,
    this.avatar = '',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _InstructorAvatar(name: instructor, avatar: avatar, size: 34, fontSize: 13),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            instructor,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF263C38),
            ),
          ),
        ),
      ],
    );
  }
}

class _InstructorAvatar extends StatelessWidget {
  const _InstructorAvatar({
    required this.name,
    required this.avatar,
    required this.size,
    required this.fontSize,
  });

  final String name;
  final String avatar;
  final double size;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final url = resolveMediaUrl(avatar);

    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: url.isEmpty
            ? _initial()
            : Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _initial(),
              ),
      ),
    );
  }

  Widget _initial() {
    return Container(
      color: const Color(0xFFE4F2EE),
      alignment: Alignment.center,
      child: Text(
        name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : '?',
        style: GoogleFonts.inter(
          color: const Color(0xFF075E4D),
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
