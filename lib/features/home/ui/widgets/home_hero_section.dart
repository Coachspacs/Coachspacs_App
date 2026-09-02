import 'package:flutter/material.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        0,
      ),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F6F1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD5EAE3),
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
              color: const Color(0xFFD4F3E9),
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: const Text(
              'PREMIUM MENTORSHIP',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w800,
                color: Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Master new skills with expert coaches',
            style: TextStyle(
              fontSize: 25,
              height: 1.08,
              fontWeight: FontWeight.w900,
              color: Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 9),

          const Text(
            'Personalized learning paths led by industry '
                'experts to help you elevate your career.',
            style: TextStyle(
              fontSize: 11,
              height: 1.5,
              color: Color(0xFF5F716C),
            ),
          ),

          const SizedBox(height: 15),

          Container(
            height: 43,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(11),
              border: Border.all(
                color: const Color(0xFFD6E5E1),
              ),
            ),
            child: const Row(
              children: [
                SizedBox(width: 12),
                Icon(
                  Icons.search,
                  size: 18,
                  color: Color(0xFF78908A),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'What do you want to learn?',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF8A9995),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF075E4D),
                      foregroundColor:
                      Colors.white,
                      elevation: 0,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Explore Courses',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton(
                    onPressed: () {},
                    style:
                    OutlinedButton.styleFrom(
                      foregroundColor:
                      const Color(
                        0xFF075E4D,
                      ),
                      side: const BorderSide(
                        color: Color(
                          0xFF075E4D,
                        ),
                      ),
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Start for Free',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            height: 125,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(14),
            ),
            child: const Center(
              child: Icon(
                Icons.image_outlined,
                size: 30,
                color: Color(0xFF9AAAA5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}