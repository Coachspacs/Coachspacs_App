import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/app_routes.dart';
import 'package:coach_space/features/home/data/models/course.dart';
import 'package:coach_space/features/home/ui/widgets/course_cover_image.dart';

class FeaturedCourseCard extends StatelessWidget {
  const FeaturedCourseCard({
    super.key,
    required this.course,
  });

  final Course course;

  void _openCourse(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.courseDetails,
      arguments: course,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: InkWell(
        onTap: () => _openCourse(context),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 175,
              width: double.infinity,
              child: CourseCoverImage(
                imageUrl: course.coverImageUrl,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 17,
                        color: Color(0xFFF2B52E),
                      ),

                      const SizedBox(width: 4),

                      Text(
                        course.rating
                            .toStringAsFixed(1),
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color:
                          const Color(0xFF344842),
                        ),
                      ),

                      const SizedBox(width: 4),

                      Text(
                        '(${course.reviewCount})',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color:
                          const Color(0xFF81908C),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 9),

                  Text(
                    course.title,
                    maxLines: 2,
                    overflow:
                    TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.25,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF073F38),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        size: 16,
                        color: Color(0xFF81908C),
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(
                          course.instructor.name,
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color:
                            const Color(0xFF71807C),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 13),

                  Row(
                    children: [
                      Text(
                        course.formattedPrice,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color:
                          const Color(0xFF075E4D),
                        ),
                      ),

                      const Spacer(),

                      SizedBox(
                        height: 38,
                        child: ElevatedButton(
                          onPressed: () =>
                              _openCourse(context),
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF075E4D),
                            foregroundColor:
                            Colors.white,
                            elevation: 0,
                            padding:
                            const EdgeInsets
                                .symmetric(
                              horizontal: 15,
                            ),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                9,
                              ),
                            ),
                          ),
                          child: Text(
                            'View Course',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}