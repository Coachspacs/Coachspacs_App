import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUserCard extends StatelessWidget {
  const ProfileUserCard({
    super.key,
    required this.name,
    required this.role,
    required this.avatar,
  });

  final String name;
  final String role;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    final firstLetter = name.trim().isNotEmpty
        ? name.trim().substring(0, 1).toUpperCase()
        : 'S';

    return Column(
      children: [
        // =====================================================
        // AVATAR
        // =====================================================

        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Color(0xFF075E4D),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: avatar.isNotEmpty
                ? Image.network(
              avatar,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return _LetterAvatar(letter: firstLetter);
              },
            )
                : _LetterAvatar(letter: firstLetter),
          ),
        ),

        const SizedBox(height: 10),

        // =====================================================
        // NAME
        // =====================================================

        Text(
          name,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF073F38),
          ),
        ),

        const SizedBox(height: 6),

        // =====================================================
        // ROLE BADGE
        // =====================================================

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE2F3ED),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.school_outlined,
                size: 11,
                color: Color(0xFF075E4D),
              ),

              const SizedBox(width: 4),

              Text(
                role,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 5),

              Text(
                '•',
                style: GoogleFonts.inter(


                  fontSize: 12,
                  color: const Color(0xFF075E4D),
                ),
              ),

              const SizedBox(width: 5),

              Text(
                'Information Technology',
                style: GoogleFonts.inter(


                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF48736A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LetterAvatar extends StatelessWidget {
  const _LetterAvatar({
    required this.letter,
  });

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        letter,
        style: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}