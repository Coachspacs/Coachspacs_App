import 'package:equatable/equatable.dart';

import 'category.dart';
import 'course.dart';

/// Aggregate payload that fully describes the home screen content.
class HomeData extends Equatable {
  const HomeData({
    required this.categories,
    required this.featuredCourses,
    required this.trendingCourses,
  });

  final List<Category> categories;
  final List<Course> featuredCourses;
  final List<Course> trendingCourses;

  bool get isEmpty =>
      categories.isEmpty && featuredCourses.isEmpty && trendingCourses.isEmpty;

  @override
  List<Object?> get props => [categories, featuredCourses, trendingCourses];
}
