import 'package:flutter/material.dart';

import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/profile/ui/widgets/browse_courses/browse_courses_header.dart';
import 'package:coach_space/features/profile/ui/widgets/browse_courses/course_card.dart';

class BrowseCoursesScreen extends StatefulWidget {
  const BrowseCoursesScreen({super.key});

  @override
  State<BrowseCoursesScreen> createState() =>
      _BrowseCoursesScreenState();
}

class _BrowseCoursesScreenState extends State<BrowseCoursesScreen> {
  CourseFilter _selectedFilter = CourseFilter.all;

  final List<_CourseData> _courses = [
    const _CourseData(
      title: 'React 19 & Next.js App Router Masterclass',
      instructor: 'Mohamed Katanani',
      progress: 0.75,
      status: CourseStatus.inProgress,
    ),
    const _CourseData(
      title: 'Building Professional UI/UX Design Systems with Figma',
      instructor: 'Dr. Tareq Al-Mansoor',
      progress: 1.0,
      status: CourseStatus.completed,
    ),
    const _CourseData(
      title: 'Python Machine Learning & AI Fundamentals',
      instructor: 'Dr. Tareq Al-Mansoor',
      progress: 0.30,
      status: CourseStatus.inProgress,
    ),
  ];

  List<_CourseData> get _filteredCourses {
    switch (_selectedFilter) {
      case CourseFilter.all:
        return _courses;

      case CourseFilter.inProgress:
        return _courses
            .where(
              (course) =>
          course.status == CourseStatus.inProgress,
        )
            .toList();

      case CourseFilter.completed:
        return _courses
            .where(
              (course) =>
          course.status == CourseStatus.completed,
        )
            .toList();
    }
  }

  int get _inProgressCount {
    return _courses
        .where(
          (course) => course.status == CourseStatus.inProgress,
    )
        .length;
  }

  int get _completedCount {
    return _courses
        .where(
          (course) => course.status == CourseStatus.completed,
    )
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrowseCoursesHeader(
                    selectedStatus: _selectedFilter,
                    allCount: _courses.length,
                    inProgressCount: _inProgressCount,
                    completedCount: _completedCount,
                    onStatusChanged: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 650;

                      if (isMobile) {
                        return Column(
                          children: _filteredCourses
                              .map(
                                (course) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: 16,
                              ),
                              child: CourseCard(
                                title: course.title,
                                instructor: course.instructor,
                                progress: course.progress,
                                status: course.status,
                                onPressed: () {},
                              ),
                            ),
                          )
                              .toList(),
                        );
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics:
                        const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.82,
                        ),
                        itemCount: _filteredCourses.length,
                        itemBuilder: (context, index) {
                          final course = _filteredCourses[index];

                          return CourseCard(
                            title: course.title,
                            instructor: course.instructor,
                            progress: course.progress,
                            status: course.status,
                            onPressed: () {},
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CourseData {
  const _CourseData({
    required this.title,
    required this.instructor,
    required this.progress,
    required this.status,
  });

  final String title;
  final String instructor;
  final double progress;
  final CourseStatus status;
}