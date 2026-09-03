import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';

import '../../../../home/data/models/mock_home_data.dart';

class CourseDetailsTopBar extends StatelessWidget {
  const CourseDetailsTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userName = MockHomeData.currentUser.name;

    final userInitial = userName.trim().isNotEmpty
        ? userName.trim()[0].toLowerCase()
        : 'u';

    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE2EBE8),
          ),
        ),
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 36,
              minHeight: 36,
            ),
            icon: const Icon(
              Icons.arrow_back,
              size: 21,
              color: Color(0xFF263C38),
            ),
          ),

          const SizedBox(width: 8),

          // Title
          Text(
            'Course Details',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),

          const Spacer(),

          // User Profile
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.profile,
              );
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFFE7F5F0),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                userInitial,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF075E4D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}