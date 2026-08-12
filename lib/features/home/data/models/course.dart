import 'package:equatable/equatable.dart';

import 'instructor.dart';

/// Course summary displayed on featured and trending home cards.
class Course extends Equatable {
  const Course({
    required this.id,
    required this.title,
    required this.instructor,
    this.coverImageUrl,
    this.categoryLabel,
    this.rating = 0,
    this.reviewCount = 0,
    this.price = 0,
    this.currency = 'USD',
  });

  final String id;
  final String title;
  final Instructor instructor;
  final String? coverImageUrl;
  final String? categoryLabel;
  final double rating;
  final int reviewCount;
  final double price;
  final String currency;

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  @override
  List<Object?> get props => [
        id,
        title,
        instructor,
        coverImageUrl,
        categoryLabel,
        rating,
        reviewCount,
        price,
        currency,
      ];
}
