import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/routing/routes.dart';
import '../widgets/my_path_goal/my_path_goal_continue_button.dart';
import '../widgets/my_path_goal/my_path_goal_header.dart';
import '../widgets/my_path_goal/my_path_goal_options.dart';
import '../widgets/my_path_goal/my_path_goal_roadmap.dart';

class MyPathGoalScreen extends StatelessWidget {
  const MyPathGoalScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyPathGoalHeader(),

              const SizedBox(height: 14),

              const MyPathGoalRoadmap(),

              const SizedBox(height: 14),

              const MyPathGoalOptions(),

              const SizedBox(height: 26),

              MyPathGoalContinueButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.studentMyPathLevel,
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
