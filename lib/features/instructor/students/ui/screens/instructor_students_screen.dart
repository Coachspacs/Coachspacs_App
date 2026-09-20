import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/helpers/failure_messages.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';
import 'package:coach_space/features/instructor/students/logic/cubit/instructor_students_cubit.dart';
import 'package:coach_space/features/instructor/students/ui/widgets/instructor_students_header.dart';
import 'package:coach_space/features/instructor/students/ui/widgets/instructor_students_stats.dart';
import 'package:coach_space/features/instructor/students/ui/widgets/instructor_student_card.dart';

class InstructorStudentsScreen extends StatefulWidget {
  const InstructorStudentsScreen({
    super.key,
  });

  @override
  State<InstructorStudentsScreen> createState() =>
      _InstructorStudentsScreenState();
}

class _InstructorStudentsScreenState
    extends State<InstructorStudentsScreen> {
  int _selectedFilter = 0;
  String _searchQuery = '';
  int? _selectedCourseId;

  void _handleNavigation(
      BuildContext context,
      int index,
      ) {
    switch (index) {

      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorDashboard,
              (route) => false,
        );
        break;

      case 1:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorCourses,
              (route) => false,
        );
        break;

      case 2:
        break;

      case 3:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.instructorProfile,
              (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDefault,

      body: SafeArea(
        child: Column(
          children: [

            const InstructorStudentsHeader(),

            const _StudentsPageTitle(),

            Expanded(
              child: BlocProvider(
                create: (_) {
                  final cubit = getIt<InstructorStudentsCubit>();
                  cubit.load();
                  return cubit;
                },
                child: BlocBuilder<InstructorStudentsCubit,
                    InstructorStudentsState>(
                  builder: (context, state) {
                    return switch (state) {
                      InstructorStudentsInitial() ||
                      InstructorStudentsLoading() => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF075E4D),
                        ),
                      ),
                      InstructorStudentsFailure() => _StudentsFailureView(
                        message: localizedFailureMessage(
                          context,
                          state.kind,
                          state.message,
                        ),
                        onRetry: () =>
                            context.read<InstructorStudentsCubit>().load(),
                      ),
                      InstructorStudentsSuccess() => _StudentsContent(
                        state: state,
                        searchQuery: _searchQuery,
                        selectedFilter: _selectedFilter,
                        selectedCourseId: _selectedCourseId,
                        onSearchChanged: (value) {
                          setState(() => _searchQuery = value);
                        },
                        onFilterChanged: (index) {
                          setState(() => _selectedFilter = index);
                        },
                        onCourseChanged: (courseId) {
                          setState(() => _selectedCourseId = courseId);
                        },
                      ),
                    };
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: 2,
        navType: NavType.instructor,
        onItemSelected: (index) {
          _handleNavigation(
            context,
            index,
          );
        },
      ),
    );
  }
}

class _StudentsContent extends StatelessWidget {
  const _StudentsContent({
    required this.state,
    required this.searchQuery,
    required this.selectedFilter,
    required this.selectedCourseId,
    required this.onSearchChanged,
    required this.onFilterChanged,
    required this.onCourseChanged,
  });

  final InstructorStudentsSuccess state;
  final String searchQuery;
  final int selectedFilter;
  final int? selectedCourseId;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<int> onFilterChanged;
  final ValueChanged<int?> onCourseChanged;

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered(state.students);

    final double avgCompletion = state.students.isEmpty
        ? 0
        : (state.students.fold<int>(
                0, (sum, s) => sum + s.progressPercent)) /
            state.students.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        24,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          InstructorStudentsStats(
            total: state.totalStudents,
            active: state.activeStudents,
            completed: state.completedStudents,
            avgCompletionPercent: avgCompletion,
          ),

          const SizedBox(height: 14),

          if (state.courses.isNotEmpty) ...[
            _buildCourseDropdown(),
            const SizedBox(height: 12),
          ],

          _buildSearchField(),

          const SizedBox(height: 12),

          _buildFilters(),

          const SizedBox(height: 14),

          if (filtered.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 28,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0xFFDDE8E5),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.people_outline_rounded,
                    size: 30,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.students.isEmpty
                        ? 'No students yet. Students who enroll in your courses will appear here.'
                        : 'No students match the current filters.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      height: 1.4,
                      color: const Color(0xFF899792),
                    ),
                  ),
                ],
              ),
            )
          else
            ...filtered.map(
              (student) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: InstructorStudentCard(
                  student: student,
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<EnrolledStudent> _filtered(List<EnrolledStudent> students) {
    final query = searchQuery.trim().toLowerCase();

    return students.where((entry) {
      final matchesSearch = query.isEmpty ||
          entry.name.toLowerCase().contains(query) ||
          entry.email.toLowerCase().contains(query);

      final matchesCourse =
          selectedCourseId == null || entry.courseId == selectedCourseId;

      final matchesFilter = switch (selectedFilter) {
        1 => entry.progressPercent > 0 && entry.progressPercent < 100,
        2 => entry.isCompleted,
        _ => true,
      };

      return matchesSearch && matchesCourse && matchesFilter;
    }).toList();
  }

  Widget _buildCourseDropdown() {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDDE8E5),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int?>(
          isExpanded: true,
          value: selectedCourseId,
          hint: Text(
            'Filter by course',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF8A9894),
            ),
          ),
          icon: const Icon(
            Icons.expand_more_rounded,
            color: Color(0xFF667570),
          ),
          items: [
            const DropdownMenuItem<int?>(
              value: null,
              child: Text(
                'All courses',
                style: TextStyle(fontSize: 14),
              ),
            ),
            ...state.courses.map(
              (course) => DropdownMenuItem<int?>(
                value: course.id,
                child: Text(
                  course.displayTitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
          onChanged: onCourseChanged,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFDDE8E5),
        ),
      ),
      child: TextField(
        onChanged: onSearchChanged,
        style: GoogleFonts.inter(
          fontSize: 15,
          color: const Color(0xFF173D37),
        ),
        decoration: InputDecoration(
          hintText: 'Search students...',
          hintStyle: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF8A9894),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 20,
            color: Color(0xFF82918D),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    const filters = [
      'All',
      'Active',
      'Completed',
    ];

    return Container(
      height: 42,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1EF),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: List.generate(
          filters.length,
              (index) {
            final bool isSelected =
                selectedFilter == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  onFilterChanged(index);
                },
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 180,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF075E4D)
                        : Colors.transparent,
                    borderRadius:
                    BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    filters[index],
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF667570),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StudentsFailureView extends StatelessWidget {
  const _StudentsFailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outline_rounded,
              size: 46,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: const Color(0xFF71827E),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 17),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentsPageTitle extends StatelessWidget {
  const _StudentsPageTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        16,
        18,
        6,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  'Enrolled Students',
                  style: GoogleFonts.inter(
                    fontSize: 23,
                    height: 1.1,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF073F38),
                    letterSpacing: -0.3,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Manage and track your students',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF788681),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}