// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_course_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogCourseDto _$CatalogCourseDtoFromJson(Map<String, dynamic> json) =>
    CatalogCourseDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      category: CategoryDto.fromJson(json['category'] as Map<String, dynamic>),
      instructor: InstructorSummaryDto.fromJson(
        json['instructor'] as Map<String, dynamic>,
      ),
      level: json['level'] as String,
      language: json['language'] as String,
      price: json['price'] as String,
      isFree: boolFromJson(json['is_free']),
      coverImage: json['cover_image'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
    );

Map<String, dynamic> _$CatalogCourseDtoToJson(CatalogCourseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category.toJson(),
      'instructor': instance.instructor.toJson(),
      'level': instance.level,
      'language': instance.language,
      'price': instance.price,
      'is_free': instance.isFree,
      'cover_image': instance.coverImage,
      'created_at': instance.createdAt.toIso8601String(),
      'published_at': instance.publishedAt?.toIso8601String(),
    };

InstructorSummaryDto _$InstructorSummaryDtoFromJson(
  Map<String, dynamic> json,
) => InstructorSummaryDto(
  id: (json['id'] as num).toInt(),
  fullName: json['full_name'] as String? ?? '',
  avatar: json['avatar'] as String? ?? '',
);

Map<String, dynamic> _$InstructorSummaryDtoToJson(
  InstructorSummaryDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'full_name': instance.fullName,
  'avatar': instance.avatar,
};

CourseDetailDto _$CourseDetailDtoFromJson(Map<String, dynamic> json) =>
    CourseDetailDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      category: CategoryDto.fromJson(json['category'] as Map<String, dynamic>),
      instructor: InstructorSummaryDto.fromJson(
        json['instructor'] as Map<String, dynamic>,
      ),
      level: json['level'] as String,
      language: json['language'] as String,
      price: json['price'] as String,
      isFree: boolFromJson(json['is_free']),
      coverImage: json['cover_image'] as String? ?? '',
      status: json['status'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => CourseSectionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalLessons: intFromJson(json['total_lessons']),
      totalDurationMinutes: intFromJson(json['total_duration_minutes']),
      isEnrolled: boolFromJson(json['is_enrolled']),
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
    );

Map<String, dynamic> _$CourseDetailDtoToJson(CourseDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category.toJson(),
      'instructor': instance.instructor.toJson(),
      'level': instance.level,
      'language': instance.language,
      'price': instance.price,
      'is_free': instance.isFree,
      'cover_image': instance.coverImage,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'published_at': instance.publishedAt?.toIso8601String(),
      'sections': instance.sections.map((e) => e.toJson()).toList(),
      'total_lessons': instance.totalLessons,
      'total_duration_minutes': instance.totalDurationMinutes,
      'is_enrolled': instance.isEnrolled,
    };

CourseSectionDto _$CourseSectionDtoFromJson(Map<String, dynamic> json) =>
    CourseSectionDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      order: (json['order'] as num).toInt(),
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => CourseLessonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseSectionDtoToJson(CourseSectionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'lessons': instance.lessons.map((e) => e.toJson()).toList(),
    };

CourseLessonDto _$CourseLessonDtoFromJson(Map<String, dynamic> json) =>
    CourseLessonDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      durationMinutes: intFromJson(json['duration_minutes']),
      order: (json['order'] as num).toInt(),
      isPreview: json['is_preview'] == null
          ? false
          : boolFromJson(json['is_preview']),
      videoUrl: json['video_url'] as String? ?? '',
    );

Map<String, dynamic> _$CourseLessonDtoToJson(CourseLessonDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration_minutes': instance.durationMinutes,
      'order': instance.order,
      'is_preview': instance.isPreview,
      'video_url': instance.videoUrl,
    };
