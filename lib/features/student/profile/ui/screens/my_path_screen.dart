import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/routing/routes.dart';
import '../widgets/my_path/my_path_benefits.dart';
import '../widgets/my_path/my_path_career_header.dart';
import '../widgets/my_path/my_path_milestones.dart';
import '../widgets/my_path/my_path_roadmap.dart';
import '../widgets/my_path/my_path_start_button.dart';

class MyPathScreen extends StatelessWidget {
  const MyPathScreen({super.key});

  static const Color _backgroundColor = Color(0xFFF7FAF9);
  static const Color _primaryColor = Color(0xFF075E4D);
  static const Color _textColor = Color(0xFF102A2A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,

      appBar: AppBar(
        backgroundColor: _backgroundColor,
        foregroundColor: _textColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,

        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 23,
            color: _textColor,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),

        leadingWidth: 52,
        centerTitle: false,
        titleSpacing: 0,

        title: Text(
          'My Path',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _primaryColor,
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            10,
            16,
            32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyPathCareerHeader(),

              const SizedBox(height: 12),

              const MyPathRoadmap(),

              const SizedBox(height: 10),

              const Text(
                'A clear, guided step-by-step roadmap tailored to your schedule, skill level, and ambitions.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.7,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF61716F),
                ),
              ),

              const SizedBox(height: 22),

              const MyPathMilestones(),

              const SizedBox(height: 22),

              Row(
                children: [
                  const Icon(
                    Icons.bolt_rounded,
                    size: 19,
                    color: _primaryColor,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Why My Path?',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: _textColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const MyPathBenefits(),

              const SizedBox(height: 26),

              MyPathStartButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.studentMyPathGoal,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}