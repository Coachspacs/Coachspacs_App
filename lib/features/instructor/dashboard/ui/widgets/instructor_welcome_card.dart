import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/routing/routes.dart';

class InstructorWelcomeCard extends StatelessWidget {
  const InstructorWelcomeCard({
    super.key,
    this.coachName,
  });

  final String? coachName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        18,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B6656),
            Color(0xFF084D43),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Decorative circle
          Positioned(
            right: -35,
            top: -40,
            child: Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ),
                  width: 20,
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'WELCOME BACK, COACH',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.7,
                  color: const Color(0xFFBCEDE0),
                ),
              ),

              const SizedBox(height: 7),

              Row(
                children: [
                  Text(
                    'Welcome back ,',
                    style: GoogleFonts.inter(
                      fontSize: 21,
                      height: 1.15,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 7),

                  const Icon(
                    Icons.waving_hand_rounded,
                    color: Color(0xFFFFCA28),
                    size: 22,
                  ),
                ],
              ),

              const SizedBox(height: 2),

              Text(
                coachName?.isNotEmpty == true
                    ? coachName!
                    : 'Coach',
                style: GoogleFonts.inter(
                  fontSize: 21,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Manage your courses, students and '
                    'teaching journey from one place.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  height: 1.45,
                  color: const Color(0xFFD5E8E3),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                height: 38,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.createInstructorCourse,
                    );
                  },
                  icon: const Icon(
                    Icons.add_rounded,
                    size: 17,
                  ),
                  label: Text(
                    'Create New Course',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor:
                    const Color(0xFF075E4D),
                    elevation: 0,
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}