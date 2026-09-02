import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseCreationStepIndicator extends StatelessWidget {
  const CourseCreationStepIndicator({
    super.key,
    required this.currentStep,
  });

  final int currentStep;

  static const List<String> _steps = [
    'Course Info',
    'Curriculum',
    'Review & Publish',
  ];

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / (_steps.length - 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =================================================
        // PROGRESS BAR
        // =================================================

        Row(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      // Background
                      Container(
                        height: 4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCEAE6),
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      ),

                      // Progress
                      AnimatedContainer(
                        duration:
                        const Duration(milliseconds: 250),
                        height: 4,
                        width: constraints.maxWidth * progress,
                        decoration: BoxDecoration(
                          color: const Color(0xFF075E4D),
                          borderRadius:
                          BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(width: 10),

            Text(
              'Step ${currentStep + 1} of ${_steps.length}',
              style: GoogleFonts.inter(
                fontSize: 7.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF71807C),
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        // =================================================
        // STEP LABELS
        // =================================================

        Row(
          children: List.generate(
            _steps.length,
                (index) {
              final isActive = index == currentStep;
              final isCompleted = index < currentStep;

              return Expanded(
                child: Align(
                  alignment: index == 0
                      ? Alignment.centerLeft
                      : index == _steps.length - 1
                      ? Alignment.centerRight
                      : Alignment.center,
                  child: Text(
                    _steps[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 7,
                      fontWeight:
                      isActive || isCompleted
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color:
                      isActive || isCompleted
                          ? const Color(0xFF075E4D)
                          : const Color(0xFF899792),
                    ),
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