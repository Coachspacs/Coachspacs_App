import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_top_bar.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/instructor_course/instructor_course_card.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/instructor_course/instructor_courses_approval_banner.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/instructor_course/instructor_courses_filter.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/instructor_course/instructor_courses_header.dart';

class InstructorCoursesScreen extends StatefulWidget {
  const InstructorCoursesScreen({super.key});

  @override
  State<InstructorCoursesScreen> createState() =>
      _InstructorCoursesScreenState();
}

class _InstructorCoursesScreenState extends State<InstructorCoursesScreen> {
  CourseFilter _selectedFilter = CourseFilter.all;

  final List<InstructorCourse> _courses = [];
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
      final page = await getIt<InstructorCoursesRepository>().getCourses(
        pageSize: 50,
      );
      if (!mounted) return;
      setState(() {
        _courses
          ..clear()
          ..addAll(page.results.map(InstructorCourse.fromDto));
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

  List<InstructorCourse> get _filteredCourses {
    switch (_selectedFilter) {
      case CourseFilter.all:
        return _courses;

      case CourseFilter.active:
      case CourseFilter.published:
        return _courses
            .where((course) => course.status == CourseStatus.published)
            .toList();

      case CourseFilter.pending:
        return _courses
            .where((course) => course.status == CourseStatus.pendingReview)
            .toList();

      case CourseFilter.drafts:
        return _courses
            .where((course) => course.status == CourseStatus.draft)
            .toList();
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      // =====================================================
      // BODY
      // =====================================================
      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // TOP BAR
            // =================================================
            const InstructorTopBar(),

            // =================================================
            // CONTENT
            // =================================================
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // =================================================
                        // APPROVAL BANNER
                        // =================================================
                        const InstructorCoursesApprovalBanner(),

                        const SizedBox(height: 18),

                        // =================================================
                        // COURSES HEADER
                        // =================================================
                        InstructorCoursesHeader(
                          onCreateCourse: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.createInstructorCourse,
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        // =================================================
                        // FILTER
                        // =================================================
                        InstructorCoursesFilter(
                          selectedFilter: _selectedFilter,
                          onFilterChanged: (filter) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        // =================================================
                        // COURSES
                        // =================================================
                        if (_isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (_errorMessage != null)
                          Center(
                            child: TextButton.icon(
                              onPressed: _loadCourses,
                              icon: const Icon(Icons.refresh_rounded),
                              label: Text('$_errorMessage Tap to retry.'),
                            ),
                          )
                        else
                          _buildCourses(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================
      bottomNavigationBar: BottomNavBarWidget(
        navType: NavType.instructor,
        currentIndex: 1,

        onItemSelected: (index) {
          switch (index) {
            // ===============================================
            // DASHBOARD
            // ===============================================

            case 0:
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.instructorDashboard,
                (route) => false,
              );
              break;

            // ===============================================
            // COURSES
            // ===============================================

            case 1:
              // We are already on Courses.
              break;

            // ===============================================
            // STUDENTS
            // ===============================================

            case 2:
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.instructorStudents,
                (route) => false,
              );
              break;

            // ===============================================
            // PROFILE
            // ===============================================

            case 3:
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.instructorProfile,
                (route) => false,
              );
              break;
          }
        },
      ),
    );
  }

  // =====================================================
  // COURSES
  // =====================================================

  Widget _buildCourses() {
    if (_filteredCourses.isEmpty) {
      return const _EmptyCoursesState();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth >= 650;

        // ===================================================
        // MOBILE
        // ===================================================

        if (!isWide) {
          return Column(
            children: _filteredCourses
                .map(
                  (course) => Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: InstructorCourseCard(course: course),
                  ),
                )
                .toList(),
          );
        }

        // ===================================================
        // WEB / TABLET
        // ===================================================

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _filteredCourses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.92,
          ),
          itemBuilder: (context, index) {
            return InstructorCourseCard(course: _filteredCourses[index]);
          },
        );
      },
    );
  }
}

// =============================================================
// EMPTY STATE
// =============================================================

class _EmptyCoursesState extends StatelessWidget {
  const _EmptyCoursesState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCE7E4)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 38,
            color: Color(0xFFB5C8C2),
          ),

          const SizedBox(height: 12),

          const Text(
            'No courses found',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263C38),
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'There are no courses in this category yet.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Color(0xFF899792)),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// COURSE MODEL
// =============================================================

class InstructorCourse {
  const InstructorCourse({
    required this.title,
    required this.image,
    required this.status,
    required this.students,
    required this.price,
    this.rejectionReason,
  });

  final String title;
  final String image;
  final CourseStatus status;
  final String students;
  final String price;
  final String? rejectionReason;

  factory InstructorCourse.fromDto(InstructorCourseDto dto) {
    final status = switch (dto.status) {
      'published' => CourseStatus.published,
      'pending' || 'pending_review' => CourseStatus.pendingReview,
      'rejected' => CourseStatus.rejected,
      _ => CourseStatus.draft,
    };
    return InstructorCourse(
      title: dto.displayTitle,
      image: dto.coverImage,
      status: status,
      students: '—',
      price: dto.price,
      rejectionReason: dto.rejectionReason,
    );
  }
}

// =============================================================
// COURSE STATUS
// =============================================================

enum CourseStatus { published, pendingReview, draft, rejected }
