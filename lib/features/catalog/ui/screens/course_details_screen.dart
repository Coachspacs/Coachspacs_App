import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/features/catalog/ui/widgets/course_details/course_details_curriculum.dart';
import 'package:coach_space/features/catalog/ui/widgets/course_details/course_details_hero.dart';
import 'package:coach_space/features/catalog/ui/widgets/course_details/course_details_includes.dart';
import 'package:coach_space/features/catalog/ui/widgets/course_details/course_details_instructor.dart';
import 'package:coach_space/features/catalog/ui/widgets/course_details/course_details_instructor_card.dart';
import 'package:coach_space/features/catalog/ui/widgets/course_details/course_details_purchase_card.dart';
import 'package:coach_space/features/catalog/ui/widgets/course_details/course_details_top_bar.dart';
import 'package:coach_space/features/home/data/models/course.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments;

    // Default values
    String title =
        'Next.js 15 & React 19 Fullstack Masterclass';

    String instructor =
        'Dr. Tareq Al-Mansoor';

    String price = '\$89.00';

    String rating = '4.9';

    String students = '2.4k';

    String image = '';

    // --------------------------------------------------
    // Course coming from Home
    // --------------------------------------------------
    if (arguments is Course) {
      title = arguments.title;
      instructor = arguments.instructor.name;
      price = arguments.formattedPrice;
      rating = arguments.rating.toStringAsFixed(1);
      students = arguments.reviewCount.toString();
      image = arguments.coverImageUrl ?? '';
    }

    // --------------------------------------------------
    // Course coming from Catalog
    // --------------------------------------------------
    else if (arguments is Map<String, dynamic>) {
      title =
          arguments['title']?.toString() ?? title;

      instructor =
          arguments['instructor']?.toString() ??
              instructor;

      price =
          arguments['price']?.toString() ?? price;

      rating =
          arguments['rating']?.toString() ?? rating;

      students =
          arguments['students']?.toString() ??
              students;

      image =
          arguments['image']?.toString() ?? image;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF9),

      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button
            const CourseDetailsTopBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  30,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // --------------------------------------------------
                    // Course Hero
                    // --------------------------------------------------
                    CourseDetailsHero(
                      title: title,
                      description:
                      'Master modern full-stack development '
                          'with practical projects and real-world '
                          'applications.',
                      imagePath: image,
                    ),

                    const SizedBox(height: 14),

                    // --------------------------------------------------
                    // Instructor
                    // --------------------------------------------------
                    CourseDetailsInstructor(
                      instructor: instructor,
                      rating: rating,
                      students: students,
                    ),

                    const SizedBox(height: 20),

                    // --------------------------------------------------
                    // Purchase
                    // --------------------------------------------------
                    CourseDetailsPurchaseCard(
                      price: price,
                      courseTitle: title,
                    ),

                    const SizedBox(height: 24),

                    // --------------------------------------------------
                    // Course Includes
                    // --------------------------------------------------
                    _sectionTitle(
                      'This course includes',
                    ),

                    const SizedBox(height: 12),

                    const CourseDetailsIncludes(),

                    const SizedBox(height: 24),

                    // --------------------------------------------------
                    // Curriculum
                    // --------------------------------------------------
                    _sectionTitle(
                      'Course Curriculum',
                    ),

                    const SizedBox(height: 12),

                    const CourseDetailsCurriculum(),

                    const SizedBox(height: 24),

                    // --------------------------------------------------
                    // About Instructor
                    // --------------------------------------------------
                    _sectionTitle(
                      'About the Instructor',
                    ),

                    const SizedBox(height: 12),

                    CourseDetailsInstructorCard(
                      instructor: instructor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 19,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF073F38),
      ),
    );
  }
}