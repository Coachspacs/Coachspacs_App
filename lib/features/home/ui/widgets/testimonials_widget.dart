import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestimonialsWidget extends StatelessWidget {
  const TestimonialsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const reviews = [
      (
      'I loved the flexibility. Being able to learn at my own pace while working full-time was exactly what I needed.',
      'Leila Hassan',
      'UX/UI Designer',
      ),
      (
      'The instructors are truly industry experts. The practical examples made a huge difference.',
      'Omar Khalid',
      'Data Science & AI',
      ),
      (
      'The project-based learning approach helped me build a strong portfolio.',
      'Sarah Ahmed',
      'Full-Stack Developer',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          Text(
            'Real stories from our community',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Careers transformed with Coach Space.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFF71807C),
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            height: 190,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: reviews.length,
              separatorBuilder: (_, __) =>
              const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final review = reviews[index];

                return Container(
                  width: 290,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFDCE6E3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        '★★★★★',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color:
                          const Color(0xFFF2B52E),
                        ),
                      ),

                      const SizedBox(height: 11),

                      Expanded(
                        child: Text(
                          '"${review.$1}"',
                          maxLines: 5,
                          overflow:
                          TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            height: 1.45,
                            color:
                            const Color(0xFF50605C),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration:
                            const BoxDecoration(
                              color: Color(0xFFDDF3EB),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              review.$2[0],
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight:
                                FontWeight.w800,
                                color:
                                const Color(
                                  0xFF075E4D,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 9),

                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.$2,
                                style:
                                GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight:
                                  FontWeight.w700,
                                  color:
                                  const Color(
                                    0xFF263B36,
                                  ),
                                ),
                              ),
                              Text(
                                review.$3,
                                style:
                                GoogleFonts.inter(
                                  fontSize: 8.5,
                                  color:
                                  const Color(
                                    0xFF81908C,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}