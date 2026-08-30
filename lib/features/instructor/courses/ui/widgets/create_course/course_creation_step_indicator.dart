import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseCreationStepIndicator
    extends StatelessWidget {
  const CourseCreationStepIndicator({
    super.key,
    required this.currentStep,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    const labels = [
      'Course Info',
      'Curriculum',
      'Review & Publish',
    ];

    return Column(
      children: [
        Row(
          children: List.generate(
            labels.length,
                (index) {
              final isActive =
                  index <= currentStep;

              return Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(
                          0xFF075E4D,
                        )
                            : const Color(
                          0xFFE6EFEC,
                        ),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style:
                        GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight:
                          FontWeight.w700,
                          color: isActive
                              ? Colors.white
                              : const Color(
                            0xFF7A8984,
                          ),
                        ),
                      ),
                    ),

                    if (index < 2)
                      Expanded(
                        child: Container(
                          height: 2,
                          margin:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 5,
                          ),
                          color: index <
                              currentStep
                              ? const Color(
                            0xFF075E4D,
                          )
                              : const Color(
                            0xFFDCE8E4,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 6),

        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: List.generate(
            labels.length,
                (index) {
              return Text(
                labels[index],
                style: GoogleFonts.inter(
                  fontSize: 7.5,
                  fontWeight:
                  index == currentStep
                      ? FontWeight.w700
                      : FontWeight.w500,
                  color: index == currentStep
                      ? const Color(0xFF075E4D)
                      : const Color(
                    0xFF899792,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}