import 'package:flutter/material.dart';
import 'package:coach_space/core/helpers/context_extensions.dart';

import '../widgets/my_path_hours/my_path_hours_header.dart';
import '../widgets/my_path_hours/my_path_hours_roadmap.dart';
import '../widgets/my_path_hours/my_path_hours_options.dart';
import '../widgets/my_path_hours/my_path_hours_continue_button.dart';

class MyPathHoursScreen extends StatelessWidget {
  const MyPathHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7FAF9),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,

        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 23,
            color: Color(0xFF172B2A),
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),

        leadingWidth: 56,
        titleSpacing: 0,
        centerTitle: false,

        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.myPathTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF075E4D),
            ),
          ),
        ),
      ),

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyPathHoursHeader(),

              const SizedBox(height: 12),

              const MyPathHoursRoadmap(),

              const SizedBox(height: 14),

              const MyPathHoursOptions(),

              const SizedBox(height: 26),

              MyPathHoursContinueButton(
                onPressed: () {
                  // TODO: Navigate to the next My Path step.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}