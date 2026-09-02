import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorCoursesApprovalBanner
    extends StatelessWidget {
  const InstructorCoursesApprovalBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFDCE8E4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFE5F5F0),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_outlined,
              size: 16,
              color: Color(0xFF075E4D),
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Instructor Account Approval',
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight:
                          FontWeight.w700,
                          color:
                          const Color(0xFF073F38),
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color:
                        const Color(0xFFDDF3EB),
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Approved',
                        style:
                        GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight:
                          FontWeight.w700,
                          color:
                          const Color(0xFF075E4D),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 3),

                Text(
                  'Your instructor account is fully approved and active.',
                  maxLines: 1,
                  overflow:
                  TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color:
                    const Color(0xFF7B8985),
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