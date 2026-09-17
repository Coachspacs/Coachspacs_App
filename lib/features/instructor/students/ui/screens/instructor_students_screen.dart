import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/theming/app_colors.dart';


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

  final List<_StudentData> _students = const [
    _StudentData(
      name: 'Ahmad Hassan',
      course: 'Flutter Architecture',
      progress: 85,
      status: 'Active',
      lastActive: '2 hours ago',
      initials: 'AH',
    ),
    _StudentData(
      name: 'Sara Riad',
      course: 'UI/UX Masterclass',
      progress: 40,
      status: 'Active',
      lastActive: '1 day ago',
      initials: 'SR',
    ),
    _StudentData(
      name: 'Omar Ali',
      course: 'Applied AI with Python',
      progress: 65,
      status: 'Active',
      lastActive: '3 hours ago',
      initials: 'OA',
    ),
    _StudentData(
      name: 'Nour Khaled',
      course: 'React 19 & Next.js',
      progress: 100,
      status: 'Completed',
      lastActive: '2 days ago',
      initials: 'NK',
    ),
    _StudentData(
      name: 'Yousef Mahmoud',
      course: 'Data Science Basics',
      progress: 25,
      status: 'Inactive',
      lastActive: '1 week ago',
      initials: 'YM',
    ),
  ];

  List<_StudentData> get _filteredStudents {
    return _students.where((student) {
      final matchesSearch =
      student.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      final matchesFilter = switch (_selectedFilter) {
        1 => student.status == 'Active',
        2 => student.status == 'Completed',
        _ => true,
      };

      return matchesSearch && matchesFilter;
    }).toList();
  }


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
              child: SingleChildScrollView(
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

                    const InstructorStudentsStats(),

                    const SizedBox(height: 18),


                    _buildSearchField(),

                    const SizedBox(height: 12),


                    _buildFilters(),

                    const SizedBox(height: 14),


                    ..._filteredStudents.map(
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
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },

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
                _selectedFilter == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFilter = index;
                  });
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


class _StudentData {
  const _StudentData({
    required this.name,
    required this.course,
    required this.progress,
    required this.status,
    required this.lastActive,
    required this.initials,
  });

  final String name;
  final String course;
  final int progress;
  final String status;
  final String lastActive;
  final String initials;
}