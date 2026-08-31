import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructorSettingsHeader extends StatelessWidget {
  const InstructorSettingsHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        10,
        16,
        13,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE4ECE9),
          ),
        ),
      ),
      child: Row(
        children: [
          // =================================================
          // BACK BUTTON
          // =================================================

          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            behavior: HitTestBehavior.opaque,
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 20,
                  color: Color(0xFF073F38),
                ),
              ),
            ),
          ),

          const SizedBox(width: 4),

          // =================================================
          // TITLE
          // =================================================

          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),
        ],
      ),
    );
  }
}