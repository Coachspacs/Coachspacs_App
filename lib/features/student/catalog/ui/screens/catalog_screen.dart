import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/di/injection_container.dart';
import 'package:coach_space/core/routing/routes.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/catalog_cubit.dart';

import '../widgets/catalog/catalog_course_card.dart';
import '../widgets/catalog/catalog_filter_sheet.dart';
import '../widgets/catalog/catalog_search_bar.dart';
import '../widgets/catalog/catalog_top_bar.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final CatalogCubit _catalogCubit;

  @override
  void initState() {
    super.initState();
    _catalogCubit = getIt<CatalogCubit>()..load();
  }

  @override
  void dispose() {
    _catalogCubit.close();
    super.dispose();
  }
  // =====================================================
  // SEARCH
  // =====================================================

  String searchQuery = '';

  // =====================================================
  // CATEGORIES
  // =====================================================

  final List<String> categories = [
    'All',
    'Design',
    'Development',
    'Business',
    'Marketing',
    'Data Science',
  ];

  String selectedCategory = 'All';

  // =====================================================
  // FILTER VALUES
  // =====================================================

  String? selectedLanguage;

  String selectedLevel = 'All Levels';

  String selectedPrice = 'All Prices';

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _catalogCubit,
      child: BlocBuilder<CatalogCubit, CatalogState>(
        builder: (context, state) {
          final courses = state is CatalogSuccess
              ? state.page.results
              : const <CatalogCourseDto>[];
          final filteredCourses = _getFilteredCourses(courses);

          return Scaffold(
            backgroundColor: const Color(0xFFF7FAF9),

            body: SafeArea(
              child: Column(
                children: [
                  // =================================================
                  // TOP BAR
                  // =================================================
                  const CatalogTopBar(),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // =================================================
                          // TITLE
                          // =================================================
                          Text(
                            'Explore Courses',
                            style: GoogleFonts.inter(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF073F38),
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Find the right course to grow your skills.',
                            style: GoogleFonts.inter(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // =================================================
                          // SEARCH
                          // =================================================
                          CatalogSearchBar(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                          ),

                          const SizedBox(height: 13),

                          // =================================================
                          // CATEGORIES
                          // =================================================
                          SizedBox(
                            height: 38,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: categories.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final category = categories[index];

                                final isSelected = selectedCategory == category;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = category;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 160),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF075E4D)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF075E4D)
                                            : const Color(0xFFD3DFDB),
                                      ),
                                    ),
                                    child: Text(
                                      category,
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF344540),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 14),

                          // =================================================
                          // FILTER + SORT
                          // =================================================
                          Row(
                            children: [
                              Expanded(
                                child: _buildActionButton(
                                  icon: Icons.tune_rounded,
                                  label: 'Filters',
                                  onPressed: _openFilterSheet,
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: _buildActionButton(
                                  icon: Icons.sort_rounded,
                                  label: 'Most Popular',
                                  onPressed: _openSortSheet,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 19),

                          // =================================================
                          // HEADER
                          // =================================================
                          Row(
                            children: [
                              Text(
                                'All Courses',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF073F38),
                                ),
                              ),

                              const Spacer(),

                              Text(
                                '${filteredCourses.length} courses',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // =================================================
                          // COURSES
                          // =================================================
                          if (state is CatalogLoading ||
                              state is CatalogInitial)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(32),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          else if (state is CatalogFailure)
                            _buildLoadFailure(state.message)
                          else if (filteredCourses.isEmpty)
                            _buildEmptyState()
                          else
                            ...filteredCourses.map((course) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CatalogCourseCard(
                                  title: course.title,
                                  instructor: course.instructor.fullName,
                                  price: course.isFree
                                      ? 'Free'
                                      : '\$${course.price}',
                                  rating: '—',
                                  students: '—',
                                  image: course.coverImage,
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.courseDetails,
                                      arguments: {
                                        'id': course.id,
                                        'title': course.title,
                                        'instructor':
                                            course.instructor.fullName,
                                        'price': course.isFree
                                            ? 'Free'
                                            : '\$${course.price}',
                                        'image': course.coverImage,
                                      },
                                    );
                                  },
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // BOTTOM NAVIGATION
            // =====================================================
            bottomNavigationBar: const BottomNavBarWidget(
              navType: NavType.student,
              currentIndex: 1,
            ),
          );
        },
      ),
    );
  }

  // =====================================================
  // FILTER / SORT BUTTON
  // =====================================================

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 46,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 17, color: const Color(0xFF075E4D)),
        label: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF075E4D),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFD5E4E0)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // =====================================================
  // OPEN FILTER SHEET
  // =====================================================

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CatalogFilterSheet(
          initialLanguage: selectedLanguage,
          initialLevel: selectedLevel,
          initialPrice: selectedPrice,
          onApply: (language, level, price) {
            setState(() {
              selectedLanguage = language;

              selectedLevel = level;

              selectedPrice = price;
            });
          },
        );
      },
    );
  }

  // =====================================================
  // SORT SHEET
  // =====================================================

  void _openSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return const _SortBottomSheet();
      },
    );
  }

  // =====================================================
  // FILTER COURSES
  // =====================================================

  List<CatalogCourseDto> _getFilteredCourses(List<CatalogCourseDto> courses) {
    final query = searchQuery.trim().toLowerCase();

    return courses.where((course) {
      final title = course.title.toLowerCase();
      final instructor = course.instructor.fullName.toLowerCase();

      if (query.isNotEmpty &&
          !title.contains(query) &&
          !instructor.contains(query)) {
        return false;
      }

      final category = course.category.name.toLowerCase();

      if (selectedCategory != 'All' &&
          category != selectedCategory.toLowerCase()) {
        return false;
      }

      return true;
    }).toList();
  }

  Widget _buildLoadFailure(String message) {
    return Center(
      child: TextButton.icon(
        onPressed: _catalogCubit.load,
        icon: const Icon(Icons.refresh_rounded),
        label: Text('$message Tap to retry.'),
      ),
    );
  }

  // =====================================================
  // EMPTY STATE
  // =====================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE0EAE7)),
      ),
      child: Column(
        children: [
          Icon(Icons.search_off, size: 45, color: Colors.grey.shade400),

          const SizedBox(height: 12),

          Text(
            'No courses found',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Try another search.',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// SORT BOTTOM SHEET
// =====================================================

class _SortBottomSheet extends StatelessWidget {
  const _SortBottomSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort Courses',
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF073F38),
              ),
            ),

            const SizedBox(height: 16),

            const _SortOption(
              title: 'Most Popular',
              icon: Icons.local_fire_department_outlined,
            ),

            const _SortOption(
              title: 'Newest',
              icon: Icons.new_releases_outlined,
            ),

            const _SortOption(title: 'Highest Rated', icon: Icons.star_outline),

            const _SortOption(
              title: 'Price: Low to High',
              icon: Icons.arrow_upward,
            ),

            const _SortOption(
              title: 'Price: High to Low',
              icon: Icons.arrow_downward,
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// SORT OPTION
// =====================================================

class _SortOption extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SortOption({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF075E4D)),

            const SizedBox(width: 12),

            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF263B36),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
