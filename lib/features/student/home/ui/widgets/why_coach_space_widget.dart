import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WhyCoachSpaceWidget extends StatelessWidget {
  const WhyCoachSpaceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      (
      Icons.school_outlined,
      'Learn anywhere',
      'Study at your own pace from anywhere.',
      ),
      (
      Icons.people_outline,
      'Expert instructors',
      'Learn from experienced industry leaders.',
      ),
      (
      Icons.workspace_premium_outlined,
      'Global certification',
      'Recognized certificates for your progress.',
      ),
      (
      Icons.translate,
      'Bilingual learning',
      'Learn comfortably in English or Arabic.',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        28,
        16,
        28,
      ),
      color: const Color(0xFFF3F7F5),
      child: Column(
        children: [
          Text(
            'Why Coach Space?',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Everything you need to grow your skills.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFF71807C),
            ),
          ),

          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0xFFE0E9E6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4F5EF),
                        borderRadius:
                        BorderRadius.circular(11),
                      ),
                      child: Icon(
                        item.$1,
                        size: 21,
                        color:
                        const Color(0xFF075E4D),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      item.$2,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color:
                        const Color(0xFF263B36),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Expanded(
                      child: Text(
                        item.$3,
                        maxLines: 3,
                        overflow:
                        TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          height: 1.35,
                          color:
                          const Color(0xFF7A8985),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}