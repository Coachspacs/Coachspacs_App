import 'package:json_annotation/json_annotation.dart';

import 'package:coach_space/core/networking/api_json_converters.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';

part 'enrollment_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class EnrollmentDto {
  const EnrollmentDto({
    required this.id,
    required this.course,
    required this.progressPercent,
    required this.isCompleted,
    required this.enrolledAt,
    this.lastIncompleteLessonId,
    this.certificate,
    this.completedAt,
  });

  final int id;
  final EnrollmentCourseDto course;
  @JsonKey(name: 'progress_percent')
  final int progressPercent;
  @JsonKey(name: 'is_completed', fromJson: boolFromJson)
  final bool isCompleted;
  @JsonKey(name: 'last_incomplete_lesson_id')
  final int? lastIncompleteLessonId;
  final String? certificate;
  @JsonKey(name: 'enrolled_at')
  final DateTime enrolledAt;
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  factory EnrollmentDto.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollmentDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EnrollmentCourseDto {
  const EnrollmentCourseDto({
    required this.id,
    required this.title,
    this.coverImage = '',
    required this.instructor,
    this.status = '',
  });

  final int id;
  final String title;
  @JsonKey(name: 'cover_image', defaultValue: '')
  final String coverImage;
  final InstructorSummaryDto instructor;
  @JsonKey(defaultValue: '')
  final String status;

  factory EnrollmentCourseDto.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentCourseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EnrollmentCourseDtoToJson(this);
}

@JsonSerializable()
class LessonPlayerDto {
  const LessonPlayerDto({
    required this.id,
    required this.title,
    this.videoUrl = '',
    required this.durationMinutes,
    this.isPreview = false,
    required this.order,
    this.section = '',
    this.courseOutline = '',
    this.previousLessonId,
    this.nextLessonId,
  });

  final int id;
  final String title;
  @JsonKey(name: 'video_url', defaultValue: '')
  final String videoUrl;
  @JsonKey(name: 'duration_minutes', fromJson: intFromJson)
  final int durationMinutes;
  @JsonKey(name: 'is_preview', fromJson: boolFromJson)
  final bool isPreview;
  final int order;
  @JsonKey(defaultValue: '')
  final String section;
  @JsonKey(name: 'previous_lesson_id')
  final int? previousLessonId;
  @JsonKey(name: 'next_lesson_id')
  final int? nextLessonId;
  @JsonKey(name: 'course_outline', defaultValue: '')
  final String courseOutline;

  factory LessonPlayerDto.fromJson(Map<String, dynamic> json) =>
      _$LessonPlayerDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LessonPlayerDtoToJson(this);
}
