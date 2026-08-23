import 'package:flutter/material.dart';

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
      'Study at your own pace from anywhere.'
      ),
      (
      Icons.people_outline,
      'Expert instructors',
      'Learn from experienced industry leaders.'
      ),
      (
      Icons.workspace_premium_outlined,
      'Global certification',
      'Recognized certificates for your progress.'
      ),
      (
      Icons.translate,
      'Bilingual learning',
      'Learn comfortably in English or Arabic.'
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ),
      color: const Color(0xFFF0F3FF),
      child: Column(
        children: [
          const Text(
            'Why Coach Space stands out',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'The best way to grow your skills and career.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF71807C),
            ),
          ),

          const SizedBox(height: 18),

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
              childAspectRatio: 1.25,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return Container(
                padding:
                const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(14),
                  border: Border.all(
                    color:
                    const Color(0xFFE2E8E6),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Icon(
                      item.$1,
                      size: 20,
                      color:
                      const Color(0xFF075E4D),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.$2,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight:
                        FontWeight.w800,
                        color:
                        Color(0xFF263B36),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.$3,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 8,
                        height: 1.3,
                        color:
                        Color(0xFF7A8985),
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