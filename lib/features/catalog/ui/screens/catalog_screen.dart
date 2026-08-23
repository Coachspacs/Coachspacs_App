import 'package:flutter/material.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/core/widgets/bottom_nav_bar_widget.dart';
import 'package:coach_space/features/catalog/ui/widgets/catalog/catalog_course_card.dart';
import 'package:coach_space/features/catalog/ui/widgets/catalog/catalog_filter_button.dart';
import 'package:coach_space/features/catalog/ui/widgets/catalog/catalog_filter_sheet.dart';
import 'package:coach_space/features/catalog/ui/widgets/catalog/catalog_search_bar.dart';
import 'package:coach_space/features/catalog/ui/widgets/catalog/catalog_top_bar.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
  });

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String searchQuery = '';

  // Temporary data.
  // Later this will come from the API.
  final List<Map<String, dynamic>> courses = [
    {
      'title': 'Next.js 15 & React 19 Fullstack Masterclass',
      'instructor': 'Dr. Tareq Al-Mansoor',
      'price': '\$89.00',
      'rating': '4.9',
      'students': '2.4k',
      'image': '',
    },
    {
      'title': 'Flutter Mobile App Development',
      'instructor': 'Ahmed Khaled',
      'price': '\$75.00',
      'rating': '4.8',
      'students': '1.8k',
      'image': '',
    },
    {
      'title': 'UI/UX Design From Zero to Professional',
      'instructor': 'Sara Hassan',
      'price': '\$65.00',
      'rating': '4.7',
      'students': '3.1k',
      'image': '',
    },
    {
      'title': 'Python & Data Science Bootcamp',
      'instructor': 'Omar Ali',
      'price': '\$95.00',
      'rating': '4.9',
      'students': '4.2k',
      'image': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCourses = courses.where((course) {
      final title = course['title'].toString().toLowerCase();
      final instructor = course['instructor'].toString().toLowerCase();
      final query = searchQuery.trim().toLowerCase();

      if (query.isEmpty) {
        return true;
      }

      return title.contains(query) || instructor.contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF9),

      body: SafeArea(
        child: Column(
          children: [
            const CatalogTopBar(),

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
                    // Page title
                    const Text(
                      'Explore Courses',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Find the right course to grow your skills.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Search
                    CatalogSearchBar(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    // Filters + Sort
                    Row(
                      children: [
                        Expanded(
                          child: CatalogFilterButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return const CatalogFilterSheet();
                                },
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _buildSortButton(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // All Courses Header
                    Row(
                      children: [
                        const Text(
                          'All Courses',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF073F38),
                          ),
                        ),

                        const Spacer(),

                        Text(
                          '${filteredCourses.length} courses',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Courses
                    if (filteredCourses.isEmpty)
                      _buildEmptyState()
                    else
                      ...filteredCourses.map(
                            (course) {
                          return CatalogCourseCard(
                            title: course['title'].toString(),
                            instructor: course['instructor'].toString(),
                            price: course['price'].toString(),
                            rating: course['rating'].toString(),
                            students: course['students'].toString(),
                            image: course['image'].toString(),

                            // View Course
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.courseDetails,
                                arguments: course,
                              );
                            },
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: const BottomNavBarWidget(
        currentIndex: 1,
      ),
    );
  }

  // Sort Button
  Widget _buildSortButton() {
    return SizedBox(
      height: 46,
      child: OutlinedButton.icon(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            builder: (context) {
              return const _SortBottomSheet();
            },
          );
        },
        icon: const Icon(
          Icons.sort,
          size: 19,
          color: Color(0xFF075E4D),
        ),
        label: const Text(
          'Most Popular',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF075E4D),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(
            color: Color(0xFFD5E4E0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Empty Search Result
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 45,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE0EAE7),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 45,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 12),

          const Text(
            'No courses found',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: Color(0xFF073F38),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Try another search.',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

// Sort Bottom Sheet
class _SortBottomSheet extends StatelessWidget {
  const _SortBottomSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          18,
          20,
          25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort Courses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF073F38),
              ),
            ),

            const SizedBox(height: 16),

            _SortOption(
              title: 'Most Popular',
              icon: Icons.local_fire_department_outlined,
            ),

            _SortOption(
              title: 'Newest',
              icon: Icons.new_releases_outlined,
            ),

            _SortOption(
              title: 'Highest Rated',
              icon: Icons.star_outline,
            ),

            _SortOption(
              title: 'Price: Low to High',
              icon: Icons.arrow_upward,
            ),

            _SortOption(
              title: 'Price: High to Low',
              icon: Icons.arrow_downward,
            ),
          ],
        ),
      ),
    );
  }
}

class _SortOption extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SortOption({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF075E4D),
            ),

            const SizedBox(width: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}