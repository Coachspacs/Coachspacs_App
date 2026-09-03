// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollmentDto _$EnrollmentDtoFromJson(
  Map<String, dynamic> json,
) => EnrollmentDto(
  id: (json['id'] as num).toInt(),
  course: EnrollmentCourseDto.fromJson(json['course'] as Map<String, dynamic>),
  progressPercent: (json['progress_percent'] as num).toInt(),
  isCompleted: boolFromJson(json['is_completed']),
  enrolledAt: DateTime.parse(json['enrolled_at'] as String),
  lastIncompleteLessonId: (json['last_incomplete_lesson_id'] as num?)?.toInt(),
  certificate: json['certificate'] as String?,
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
);

Map<String, dynamic> _$EnrollmentDtoToJson(EnrollmentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course': instance.course.toJson(),
      'progress_percent': instance.progressPercent,
      'is_completed': instance.isCompleted,
      'last_incomplete_lesson_id': instance.lastIncompleteLessonId,
      'certificate': instance.certificate,
      'enrolled_at': instance.enrolledAt.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
    };

EnrollmentCourseDto _$EnrollmentCourseDtoFromJson(Map<String, dynamic> json) =>
    EnrollmentCourseDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      coverImage: json['cover_image'] as String,
      instructor: InstructorSummaryDto.fromJson(
        json['instructor'] as Map<String, dynamic>,
      ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$EnrollmentCourseDtoToJson(
  EnrollmentCourseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'cover_image': instance.coverImage,
  'instructor': instance.instructor.toJson(),
  'status': instance.status,
};

LessonPlayerDto _$LessonPlayerDtoFromJson(Map<String, dynamic> json) =>
    LessonPlayerDto(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      videoUrl: json['video_url'] as String,
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      isPreview: json['is_preview'] as bool,
      order: (json['order'] as num).toInt(),
      section: json['section'] as String,
      courseOutline: json['course_outline'] as String,
      previousLessonId: (json['previous_lesson_id'] as num?)?.toInt(),
      nextLessonId: (json['next_lesson_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LessonPlayerDtoToJson(LessonPlayerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'video_url': instance.videoUrl,
      'duration_minutes': instance.durationMinutes,
      'is_preview': instance.isPreview,
      'order': instance.order,
      'section': instance.section,
      'previous_lesson_id': instance.previousLessonId,
      'next_lesson_id': instance.nextLessonId,
      'course_outline': instance.courseOutline,
    };
