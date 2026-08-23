import 'package:flutter/material.dart';

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
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
              BorderRadius.circular(20),
            ),
            child: const Text(
              'BECOME AN INSTRUCTOR',
              style: TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.w800,
                color: Color(0xFF075E4D),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Join the future of learning',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'Share your knowledge with a global audience '
                'and help learners grow their careers.',
            style: TextStyle(
              fontSize: 10,
              height: 1.45,
              color: Color(0xFF60716C),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 40,
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
              child: const Text(
                'Start teaching today',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}