import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/helpers/context_extensions.dart';

class AccountSettingsProfileCard extends StatelessWidget {
  const AccountSettingsProfileCard({
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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE6EEEB),
        ),
      ),
      child: Row(
        children: [
          // =====================================================
          // AVATAR
          // =====================================================

          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF075E4D),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: avatar.isNotEmpty
                  ? Image.network(
                avatar,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return _LetterAvatar(
                    letter: firstLetter,
                  );
                },
              )
                  : _LetterAvatar(
                letter: firstLetter,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // =====================================================
          // USER INFO
          // =====================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF172C28),
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
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
                            size: 10,
                            color: Color(0xFF075E4D),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            role,
                            style: GoogleFonts.inter(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF075E4D),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),

          // =====================================================
          // ACTIVE
          // =====================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF1FFF9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF9DE6C8),
              ),
            ),
            child: Text(
              context.l10n.profileActive,
              style: GoogleFonts.inter(
                fontSize: 8.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF168A62),
              ),
            ),
          ),
        ],
      ),
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
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}