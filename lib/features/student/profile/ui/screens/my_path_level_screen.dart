import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/routing/routes.dart';
import '../widgets/my_path_goal/my_path_goal_roadmap.dart';
import '../widgets/my_path_level/my_path_level_continue_button.dart';
import '../widgets/my_path_level/my_path_level_header.dart';
import '../widgets/my_path_level/my_path_level_options.dart';

class MyPathLevelScreen extends StatelessWidget {
  const MyPathLevelScreen({super.key});

  static const Color _backgroundColor = Color(0xFFF7FAF9);
  static const Color _primaryColor = Color(0xFF075E4D);
  static const Color _textColor = Color(0xFF172B2A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
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
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 28),
          child: Column(
            children: [
              const MyPathLevelHeader(),

              const SizedBox(height: 14),

              const MyPathGoalRoadmap(),

              const SizedBox(height: 18),

              const MyPathLevelOptions(),

              const SizedBox(height: 26),

              MyPathLevelContinueButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.studentMyPathSkill,
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
