import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';

import '../widgets/browse_courses/browse_courses_header.dart';
import '../widgets/browse_courses/course_card.dart';

class BrowseCoursesScreen extends StatefulWidget {
  const BrowseCoursesScreen({super.key});

  @override
  State<BrowseCoursesScreen> createState() => _BrowseCoursesScreenState();
}

class _BrowseCoursesScreenState extends State<BrowseCoursesScreen> {
  CourseFilter _selectedFilter = CourseFilter.all;

  // =====================================================
  // COURSES
  // =====================================================

  final List<_CourseData> _courses = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final enrollments = await getIt<EnrollmentRepository>().getEnrollments(
        pageSize: 50,
      );
      if (!mounted) return;
      setState(() {
        _courses
          ..clear()
          ..addAll(
            enrollments.results.map(
              (enrollment) => _CourseData(
                title: enrollment.course.title,
                instructor: enrollment.course.instructor.fullName,
                progress: enrollment.progressPercent / 100,
                status: enrollment.isCompleted
                    ? CourseStatus.completed
                    : CourseStatus.inProgress,
              ),
            ),
          );
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Unable to load your courses.';
      });
    }
  }

  // =====================================================
  // FILTERED COURSES
  // =====================================================

  List<_CourseData> get _filteredCourses {
    return switch (_selectedFilter) {
      CourseFilter.all => _courses,
      CourseFilter.inProgress =>
        _courses
            .where((course) => course.status == CourseStatus.inProgress)
            .toList(growable: false),
      CourseFilter.completed =>
        _courses
            .where((course) => course.status == CourseStatus.completed)
            .toList(growable: false),
    };
  }

  int get _inProgressCount {
    return _courses
        .where((course) => course.status == CourseStatus.inProgress)
        .length;
  }

  int get _completedCount {
    return _courses
        .where((course) => course.status == CourseStatus.completed)
        .length;
  }

  // =====================================================
  // OPEN COURSE
  // =====================================================

  void _openCourseDetails(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.courseDetails);
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    final filteredCourses = _filteredCourses;
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =================================================
                  // HEADER
                  // =================================================
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

                  const SizedBox(height: 18),

                  // =================================================
                  // SMALL SUMMARY
                  // =================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedFilter == CourseFilter.all
                            ? 'All Courses'
                            : _selectedFilter == CourseFilter.inProgress
                            ? 'In Progress'
                            : 'Completed Courses',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF073F38),
                        ),
                      ),
                      Text(
                        '${filteredCourses.length} courses',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          color: const Color(0xFF899792),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // =================================================
                  // COURSES
                  // =================================================
                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (_errorMessage != null)
                    Center(
                      child: TextButton.icon(
                        onPressed: _loadCourses,
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text('$_errorMessage Tap to retry.'),
                      ),
                    )
                  else
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 650;

                        if (isMobile) {
                          return Column(
                            children: filteredCourses
                                .map(
                                  (course) => Padding(
                                    padding: const EdgeInsets.only(bottom: 14),
                                    child: CourseCard(
                                      title: course.title,
                                      instructor: course.instructor,
                                      progress: course.progress,
                                      status: course.status,
                                      onPressed: () {
                                        _openCourseDetails(context);
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                childAspectRatio: 0.78,
                              ),
                          itemCount: filteredCourses.length,
                          itemBuilder: (context, index) {
                            final course = filteredCourses[index];

                            return CourseCard(
                              title: course.title,
                              instructor: course.instructor,
                              progress: course.progress,
                              status: course.status,
                              onPressed: () {
                                _openCourseDetails(context);
                              },
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

// =====================================================
// COURSE DATA
// =====================================================

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
