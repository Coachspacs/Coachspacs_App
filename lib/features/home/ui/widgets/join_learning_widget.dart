import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinLearningWidget extends StatelessWidget {
  const JoinLearningWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F7F2),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD1E9E2),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: Text(
              'BECOME AN INSTRUCTOR',
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(height: 11),

          Text(
            'Join the future of learning',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Share your knowledge with a global audience '
                'and help learners grow their careers.',
            style: GoogleFonts.inter(
              fontSize: 10.5,
              height: 1.45,
              color: const Color(0xFF60716C),
            ),
          ),

          const SizedBox(height: 17),

          SizedBox(
            height: 42,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF075E4D),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Start teaching today',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}