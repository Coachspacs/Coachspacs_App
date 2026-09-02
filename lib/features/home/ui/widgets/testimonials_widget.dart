import 'package:flutter/material.dart';

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
          const Text(
            'Real stories from our community',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF073F38),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Careers transformed with Coach Space.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF71807C),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 185,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: reviews.length,
              separatorBuilder: (_, __) =>
              const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final review = reviews[index];

                return Container(
                  width: 285,
                  padding:
                  const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(14),
                    border: Border.all(
                      color:
                      const Color(0xFFDCE6E3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            '★★★★★',
                            style: TextStyle(
                              fontSize: 11,
                              color:
                              Color(0xFFF2B52E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Text(
                          '"${review.$1}"',
                          maxLines: 5,
                          overflow:
                          TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            height: 1.45,
                            color:
                            Color(0xFF50605C),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration:
                            const BoxDecoration(
                              color:
                              Color(0xFFDDF3EB),
                              shape:
                              BoxShape.circle,
                            ),
                            alignment:
                            Alignment.center,
                            child: Text(
                              review.$2[0],
                              style:
                              const TextStyle(
                                fontSize: 10,
                                fontWeight:
                                FontWeight.w800,
                                color:
                                Color(0xFF075E4D),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                review.$2,
                                style:
                                const TextStyle(
                                  fontSize: 9,
                                  fontWeight:
                                  FontWeight.w800,
                                ),
                              ),
                              Text(
                                review.$3,
                                style:
                                const TextStyle(
                                  fontSize: 8,
                                  color:
                                  Color(0xFF81908C),
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