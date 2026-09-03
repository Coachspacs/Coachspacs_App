import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorProfileUserCard extends StatelessWidget {
  final VoidCallback onEdit;

  const InstructorProfileUserCard({
    super.key,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFDDE8E5),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // =================================================
          // AVATAR
          // =================================================

          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFFE5F4F0),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'H',
              style: GoogleFonts.inter(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(width: 13),

          // =================================================
          // USER INFO
          // =================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hassan Sayed',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'Instructor',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF788681),
                  ),
                ),

                const SizedBox(height: 7),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDF6EB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Approved',
                    style: GoogleFonts.inter(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF13845F),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =================================================
          // EDIT
          // =================================================

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onEdit,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F8F7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 17,
                  color: Color(0xFF075E4D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}