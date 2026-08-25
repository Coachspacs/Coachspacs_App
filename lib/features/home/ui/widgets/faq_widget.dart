import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FaqWidget extends StatefulWidget {
  const FaqWidget({
    super.key,
  });

  @override
  State<FaqWidget> createState() =>
      _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  int? expandedIndex;

  final questions = const [
    (
    'What types of courses are available?',
    'We offer courses in technology, business, design, and personal growth.',
    ),
    (
    'Do I get a certificate after completing a course?',
    'Yes. You can receive a certificate after successfully completing the course.',
    ),
    (
    'How can I start as an instructor?',
    'Choose Become an Instructor and follow the application steps.',
    ),
    (
    'Is there a mobile app?',
    'Yes. Coach Space is designed to provide a smooth mobile learning experience.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        children: [
          Text(
            'Frequently Asked Questions',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Everything you need to know about Coach Space.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xFF71807C),
            ),
          ),

          const SizedBox(height: 18),

          ...List.generate(
            questions.length,
                (index) {
              final item = questions[index];
              final expanded =
                  expandedIndex == index;

              return Container(
                margin: const EdgeInsets.only(
                  bottom: 9,
                ),
                decoration: BoxDecoration(
                  color: expanded
                      ? const Color(0xFFE5F6F0)
                      : Colors.white,
                  borderRadius:
                  BorderRadius.circular(13),
                  border: Border.all(
                    color: const Color(0xFFDDE8E5),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: expanded,
                    onExpansionChanged: (value) {
                      setState(() {
                        expandedIndex =
                        value ? index : null;
                      });
                    },
                    tilePadding:
                    const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    childrenPadding:
                    const EdgeInsets.fromLTRB(
                      14,
                      0,
                      14,
                      14,
                    ),
                    title: Text(
                      item.$1,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color:
                        const Color(0xFF334740),
                      ),
                    ),
                    children: [
                      Align(
                        alignment:
                        Alignment.centerLeft,
                        child: Text(
                          item.$2,
                          style: GoogleFonts.inter(
                            fontSize: 9.5,
                            height: 1.4,
                            color:
                            const Color(0xFF687873),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}