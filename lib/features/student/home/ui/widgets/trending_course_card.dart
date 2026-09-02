import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coach_space/core/routing/app_routes.dart';

import '../../data/models/course.dart';
import 'course_cover_image.dart';

class TrendingCourseCard extends StatelessWidget {
  const TrendingCourseCard({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDCE7E4),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.courseDetails,
            arguments: course,
          );
        },
        child: Row(
          children: [
            SizedBox(
              width: 105,
              height: 115,
              child: CourseCoverImage(
                imageUrl: course.coverImageUrl,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    if (course.categoryLabel != null)
                      Text(
                        course.categoryLabel!,
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color:
                          const Color(0xFF075E4D),
                        ),
                      ),

                    const SizedBox(height: 5),

                    Text(
                      course.title,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                        color:
                        const Color(0xFF073F38),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text(
                          course.formattedPrice,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w800,
                            color:
                            const Color(0xFF075E4D),
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: Color(0xFFF2B52E),
                        ),

                        const SizedBox(width: 3),

                        Text(
                          course.rating
                              .toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight:
                            FontWeight.w600,
                            color:
                            const Color(0xFF71807C),
                          ),
                        ),
                      ],
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
}