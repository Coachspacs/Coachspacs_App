import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/instructor/dashboard/ui/widgets/instructor_top_bar.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/instructor_course/instructor_course_card.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/instructor_course/instructor_courses_approval_banner.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/instructor_course/instructor_courses_filter.dart';
import 'package:coach_space/features/instructor/courses/ui/widgets/instructor_course/instructor_courses_header.dart';

class InstructorCoursesScreen extends StatefulWidget {
  const InstructorCoursesScreen({
    super.key,
  });

  @override
  State<InstructorCoursesScreen> createState() =>
      _InstructorCoursesScreenState();
}

class _InstructorCoursesScreenState
    extends State<InstructorCoursesScreen> {
  CourseFilter _selectedFilter = CourseFilter.all;

  // =====================================================
  // MOCK COURSES
  // =====================================================

  final List<InstructorCourse> _courses = [
    const InstructorCourse(
      title: 'React 19 & Next.js App Router Masterclass',
      image: 'assets/images/course1.png',
      status: CourseStatus.published,
      students: '350',
      price: '\$49.00',
    ),

    const InstructorCourse(
      title: 'Applied AI with Python',
      image: 'assets/images/course2.png',
      status: CourseStatus.pendingReview,
      students: '120',
      price: '\$59.00',
    ),

    const InstructorCourse(
      title: 'Complete UI/UX Design System Guide',
      image: 'assets/images/course3.png',
      status: CourseStatus.rejected,
      students: '0',
      price: '\$39.00',
      rejectionReason:
      'Please upload an HD promo video and add at least 3 free preview lessons.',
    ),

    const InstructorCourse(
      title: 'Advanced Leadership Strategies for Modern Teams',
      image: 'assets/images/course4.png',
      status: CourseStatus.draft,
      students: '0',
      price: '\$49.00',
    ),

    const InstructorCourse(
      title:
      'The Remote Work Masterclass: Communication & Collaboration',
      image: 'assets/images/course5.png',
      status: CourseStatus.draft,
      students: '0',
      price: '\$44.00',
    ),

    const InstructorCourse(
      title: 'Peak Performance: Productivity Systems',
      image: 'assets/images/course6.png',
      status: CourseStatus.published,
      students: '215',
      price: '\$39.00',
    ),
  ];

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
            .where(
              (course) =>
          course.status == CourseStatus.published,
        )
            .toList();

      case CourseFilter.pending:
        return _courses
            .where(
              (course) =>
          course.status == CourseStatus.pendingReview,
        )
            .toList();

      case CourseFilter.drafts:
        return _courses
            .where(
              (course) =>
          course.status == CourseStatus.draft,
        )
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
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  30,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 900,
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
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
        final bool isWide =
            constraints.maxWidth >= 650;

        // ===================================================
        // MOBILE
        // ===================================================

        if (!isWide) {
          return Column(
            children: _filteredCourses
                .map(
                  (course) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 14,
                ),
                child: InstructorCourseCard(
                  course: course,
                ),
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
          physics:
          const NeverScrollableScrollPhysics(),
          itemCount: _filteredCourses.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.92,
          ),
          itemBuilder: (context, index) {
            return InstructorCourseCard(
              course: _filteredCourses[index],
            );
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
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 50,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
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
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF263C38),
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'There are no courses in this category yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF899792),
            ),
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
}

// =============================================================
// COURSE STATUS
// =============================================================

enum CourseStatus {
  published,
  pendingReview,
  draft,
  rejected,
}