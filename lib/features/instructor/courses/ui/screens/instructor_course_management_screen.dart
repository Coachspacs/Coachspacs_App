import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/course_management/instructor_course_management_header.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/course_management/instructor_course_summary_card.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/course_management/instructor_course_management_tabs.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/course_management/instructor_course_management_overview.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/course_management/instructor_course_management_content.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/course_management/instructor_course_management_students.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/course_management/instructor_course_management_analytics.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/course_management/instructor_course_management_settings.dart';

class InstructorCourseManagementScreen extends StatefulWidget {
  const InstructorCourseManagementScreen({
    super.key,
  });

  @override
  State<InstructorCourseManagementScreen> createState() =>
      _InstructorCourseManagementScreenState();
}

class _InstructorCourseManagementScreenState
    extends State<InstructorCourseManagementScreen> {
  int _selectedTab = 0;

  final List<String> _tabs = const [
    'Overview',
    'Content',
    'Students',
    'Analytics',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F7),
      body: SafeArea(
        child: Column(
          children: [
            const InstructorCourseManagementHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manage Course',
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF073F38),
                        letterSpacing: -0.4,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Manage your course content, students, and performance.',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF71807C),
                      ),
                    ),

                    const SizedBox(height: 16),

                    const InstructorCourseSummaryCard(),

                    const SizedBox(height: 18),

                    InstructorCourseManagementTabs(
                      tabs: _tabs,
                      selectedIndex: _selectedTab,
                      onTabSelected: (index) {
                        setState(() {
                          _selectedTab = index;
                        });
                      },
                    ),

                    const SizedBox(height: 18),

                    _buildTabContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 0:
        return const InstructorCourseManagementOverview();

      case 1:
        return const InstructorCourseManagementContent();

      case 2:
        return const InstructorCourseManagementStudents();

      case 3:
        return const InstructorCourseManagementAnalytics();

      case 4:
        return const InstructorCourseManagementSettings();

      default:
        return const InstructorCourseManagementOverview();
    }
  }
}