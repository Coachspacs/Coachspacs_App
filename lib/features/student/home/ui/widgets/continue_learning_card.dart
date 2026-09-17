import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF075E4D);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFD6ECE6),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12075E4D),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
              16,
              14,
              16,
              15,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF087A65),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'PRODUCT STRATEGY & LEADERSHIP',
                        style: GoogleFonts.inter(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .3,
                          color: const Color(0xFFA9E6D8),
                        ),
                      ),
                    ),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A9386),
                        borderRadius:
                        BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Lesson 7 of 11',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 9),

                Text(
                  'Defining Core Value Propositions & Metrics',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Instructor: Dr. Elena Rostova • Stanford d.school',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: const Color(0xFF9ED9CD),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              13,
              16,
              14,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '65% completed',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF283630),
                      ),
                    ),
                    Text(
                      '22 mins remaining',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: const Color(0xFF3F4D48),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: .65,
                    minHeight: 8,
                    backgroundColor:
                    const Color(0xFFE3EAF4),
                    valueColor:
                    const AlwaysStoppedAnimation(
                      green,
                    ),
                  ),
                ),

                const SizedBox(height: 13),

                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      size: 12,
                      color: Color(0xFF6D8D84),
                    ),

                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        '2 lessons left to earn +50 XP',
                        style: GoogleFonts.inter(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          color: green,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {},
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor: green,
                          foregroundColor:
                          Colors.white,
                          elevation: 0,
                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(11),
                          ),
                        ),
                        child: Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            Text(
                              'Resume',
                              style:
                              GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Icon(
                              Icons.play_circle_outline,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}