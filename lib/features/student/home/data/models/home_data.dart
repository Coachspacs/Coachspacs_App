import 'package:equatable/equatable.dart';

import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

import 'category.dart';

/// Aggregate payload that fully describes the home screen content.
class HomeData extends Equatable {
  const HomeData({
    required this.categories,
    required this.recommendedCourses,
    this.continueEnrollment,
  });

  final List<Category> categories;
  final List<CatalogCourseDto> recommendedCourses;
  final EnrollmentDto? continueEnrollment;

  bool get isEmpty => categories.isEmpty && recommendedCourses.isEmpty;

  @override
  List<Object?> get props => [categories, recommendedCourses, continueEnrollment];
}
