import 'package:flutter/material.dart';

class FaqWidget extends StatefulWidget {
  const FaqWidget({
    super.key,
  });

  @override
  State<FaqWidget> createState() =>
      _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  int? expandedIndex = 0;

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
          const Text(
            'Frequently asked questions',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF073F38),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Everything you need to know about Coach Space.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF71807C),
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
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: expanded
                      ? const Color(0xFFE5F6F0)
                      : Colors.white,
                  borderRadius:
                  BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(
                      0xFFDDE8E5,
                    ),
                  ),
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
                    horizontal: 12,
                  ),
                  childrenPadding:
                  const EdgeInsets.fromLTRB(
                    12,
                    0,
                    12,
                    12,
                  ),
                  title: Text(
                    item.$1,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF334740),
                    ),
                  ),
                  children: [
                    Align(
                      alignment:
                      Alignment.centerLeft,
                      child: Text(
                        item.$2,
                        style: const TextStyle(
                          fontSize: 9,
                          height: 1.4,
                          color:
                          Color(0xFF687873),
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