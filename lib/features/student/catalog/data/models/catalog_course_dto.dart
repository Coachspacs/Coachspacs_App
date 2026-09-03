import 'package:json_annotation/json_annotation.dart';

import 'package:coach_space/core/networking/api_json_converters.dart';

import 'category_dto.dart';

part 'catalog_course_dto.g.dart';

/// Public course summary returned by `GET /api/catalog/courses`.
@JsonSerializable(explicitToJson: true)
class CatalogCourseDto {
  const CatalogCourseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.instructor,
    required this.level,
    required this.language,
    required this.price,
    required this.isFree,
    required this.coverImage,
    required this.createdAt,
    this.publishedAt,
  });

  final int id;
  final String title;
  final String description;
  final CategoryDto category;
  final InstructorSummaryDto instructor;
  final String level;
  final String language;
  final String price;
  @JsonKey(name: 'is_free', fromJson: boolFromJson)
  final bool isFree;
  @JsonKey(name: 'cover_image')
  final String coverImage;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;

  factory CatalogCourseDto.fromJson(Map<String, dynamic> json) =>
      _$CatalogCourseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CatalogCourseDtoToJson(this);
}

@JsonSerializable()
class InstructorSummaryDto {
  const InstructorSummaryDto({
    required this.id,
    required this.fullName,
    required this.avatar,
  });

  final int id;
  @JsonKey(name: 'full_name')
  final String fullName;
  final String avatar;

  factory InstructorSummaryDto.fromJson(Map<String, dynamic> json) =>
      _$InstructorSummaryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorSummaryDtoToJson(this);
}

/// Public course detail returned by `GET /api/catalog/courses/{id}`.
@JsonSerializable(explicitToJson: true)
class CourseDetailDto {
  const CourseDetailDto({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.instructor,
    required this.level,
    required this.language,
    required this.price,
    required this.isFree,
    required this.coverImage,
    required this.status,
    required this.createdAt,
    required this.sections,
    required this.totalLessons,
    required this.totalDurationMinutes,
    required this.isEnrolled,
    this.publishedAt,
  });

  final int id;
  final String title;
  final String description;
  final CategoryDto category;
  final InstructorSummaryDto instructor;
  final String level;
  final String language;
  final String price;
  @JsonKey(name: 'is_free', fromJson: boolFromJson)
  final bool isFree;
  @JsonKey(name: 'cover_image')
  final String coverImage;
  final String status;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'published_at')
  final DateTime? publishedAt;
  final List<CourseSectionDto> sections;
  @JsonKey(name: 'total_lessons', fromJson: intFromJson)
  final int totalLessons;
  @JsonKey(name: 'total_duration_minutes', fromJson: intFromJson)
  final int totalDurationMinutes;
  @JsonKey(name: 'is_enrolled', fromJson: boolFromJson)
  final bool isEnrolled;

  factory CourseDetailDto.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CourseDetailDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CourseSectionDto {
  const CourseSectionDto({
    required this.id,
    required this.title,
    required this.order,
    required this.lessons,
  });

  final int id;
  final String title;
  final int order;
  final List<CourseLessonDto> lessons;

  factory CourseSectionDto.fromJson(Map<String, dynamic> json) =>
      _$CourseSectionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CourseSectionDtoToJson(this);
}

@JsonSerializable()
class CourseLessonDto {
  const CourseLessonDto({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.order,
    required this.isPreview,
    required this.videoUrl,
  });

  final int id;
  final String title;
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  final int order;
  @JsonKey(name: 'is_preview')
  final bool isPreview;
  @JsonKey(name: 'video_url')
  final String videoUrl;

  factory CourseLessonDto.fromJson(Map<String, dynamic> json) =>
      _$CourseLessonDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CourseLessonDtoToJson(this);
}
