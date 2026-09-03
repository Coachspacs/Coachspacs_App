import 'package:json_annotation/json_annotation.dart';

part 'instructor_course_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class InstructorCourseDto {
  const InstructorCourseDto({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.category,
    required this.level,
    required this.language,
    required this.price,
    required this.status,
    this.coverImage = '',
    this.rejectionReason,
    this.sections = const [],
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  @JsonKey(name: 'title_ar')
  final String titleAr;
  @JsonKey(name: 'title_en')
  final String titleEn;
  @JsonKey(name: 'description_ar')
  final String descriptionAr;
  @JsonKey(name: 'description_en')
  final String descriptionEn;
  final int category;
  final String level;
  final String language;
  final String price;
  final String status;
  @JsonKey(name: 'cover_image', defaultValue: '')
  final String coverImage;
  @JsonKey(name: 'rejection_reason')
  final String? rejectionReason;
  @JsonKey(defaultValue: <InstructorSectionDto>[])
  final List<InstructorSectionDto> sections;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  String get displayTitle => language == 'ar' ? titleAr : titleEn;
  String get displayDescription =>
      language == 'ar' ? descriptionAr : descriptionEn;
  factory InstructorCourseDto.fromJson(Map<String, dynamic> json) =>
      _$InstructorCourseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorCourseDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InstructorSectionDto {
  const InstructorSectionDto({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.order,
    this.lessons = const [],
  });
  final int id;
  @JsonKey(name: 'title_ar')
  final String titleAr;
  @JsonKey(name: 'title_en')
  final String titleEn;
  final int order;
  @JsonKey(defaultValue: <InstructorLessonDto>[])
  final List<InstructorLessonDto> lessons;
  factory InstructorSectionDto.fromJson(Map<String, dynamic> json) =>
      _$InstructorSectionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorSectionDtoToJson(this);
}

@JsonSerializable()
class InstructorLessonDto {
  const InstructorLessonDto({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.durationMinutes,
    required this.order,
    required this.isPreview,
    this.videoUrl = '',
  });
  final int id;
  @JsonKey(name: 'title_ar')
  final String titleAr;
  @JsonKey(name: 'title_en')
  final String titleEn;
  @JsonKey(name: 'video_url', defaultValue: '')
  final String videoUrl;
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  final int order;
  @JsonKey(name: 'is_preview')
  final bool isPreview;
  factory InstructorLessonDto.fromJson(Map<String, dynamic> json) =>
      _$InstructorLessonDtoFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorLessonDtoToJson(this);
}

/// Request body for course creation and full replacement.
@JsonSerializable()
class CourseWriteRequest {
  const CourseWriteRequest({
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.category,
    required this.level,
    required this.language,
    required this.price,
  });

  @JsonKey(name: 'title_ar')
  final String titleAr;
  @JsonKey(name: 'title_en')
  final String titleEn;
  @JsonKey(name: 'description_ar')
  final String descriptionAr;
  @JsonKey(name: 'description_en')
  final String descriptionEn;
  final int category;
  final String level;
  final String language;
  final String price;

  factory CourseWriteRequest.fromJson(Map<String, dynamic> json) =>
      _$CourseWriteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CourseWriteRequestToJson(this);
}

/// Partial request body for `PATCH /api/instructor/courses/{id}`.
@JsonSerializable(includeIfNull: false)
class CoursePatchRequest {
  const CoursePatchRequest({
    this.titleAr,
    this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
    this.category,
    this.level,
    this.language,
    this.price,
  });

  @JsonKey(name: 'title_ar')
  final String? titleAr;
  @JsonKey(name: 'title_en')
  final String? titleEn;
  @JsonKey(name: 'description_ar')
  final String? descriptionAr;
  @JsonKey(name: 'description_en')
  final String? descriptionEn;
  final int? category;
  final String? level;
  final String? language;
  final String? price;

  factory CoursePatchRequest.fromJson(Map<String, dynamic> json) =>
      _$CoursePatchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CoursePatchRequestToJson(this);
}

@JsonSerializable()
class SectionWriteRequest {
  const SectionWriteRequest({
    required this.titleAr,
    required this.titleEn,
    required this.order,
  });

  @JsonKey(name: 'title_ar')
  final String titleAr;
  @JsonKey(name: 'title_en')
  final String titleEn;
  final int order;

  factory SectionWriteRequest.fromJson(Map<String, dynamic> json) =>
      _$SectionWriteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SectionWriteRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SectionPatchRequest {
  const SectionPatchRequest({this.titleAr, this.titleEn, this.order});

  @JsonKey(name: 'title_ar')
  final String? titleAr;
  @JsonKey(name: 'title_en')
  final String? titleEn;
  final int? order;

  factory SectionPatchRequest.fromJson(Map<String, dynamic> json) =>
      _$SectionPatchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SectionPatchRequestToJson(this);
}

@JsonSerializable()
class LessonWriteRequest {
  const LessonWriteRequest({
    required this.titleAr,
    required this.titleEn,
    required this.videoUrl,
    required this.videoPublicId,
    required this.durationMinutes,
    required this.order,
    required this.isPreview,
  });

  @JsonKey(name: 'title_ar')
  final String titleAr;
  @JsonKey(name: 'title_en')
  final String titleEn;
  @JsonKey(name: 'video_url')
  final String videoUrl;
  @JsonKey(name: 'video_public_id')
  final String videoPublicId;
  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;
  final int order;
  @JsonKey(name: 'is_preview')
  final bool isPreview;

  factory LessonWriteRequest.fromJson(Map<String, dynamic> json) =>
      _$LessonWriteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LessonWriteRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class LessonPatchRequest {
  const LessonPatchRequest({
    this.titleAr,
    this.titleEn,
    this.videoUrl,
    this.videoPublicId,
    this.durationMinutes,
    this.order,
    this.isPreview,
  });

  @JsonKey(name: 'title_ar')
  final String? titleAr;
  @JsonKey(name: 'title_en')
  final String? titleEn;
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @JsonKey(name: 'video_public_id')
  final String? videoPublicId;
  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;
  final int? order;
  @JsonKey(name: 'is_preview')
  final bool? isPreview;

  factory LessonPatchRequest.fromJson(Map<String, dynamic> json) =>
      _$LessonPatchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LessonPatchRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CourseReorderRequest {
  const CourseReorderRequest({required this.sections});

  final List<SectionReorderRequest> sections;

  factory CourseReorderRequest.fromJson(Map<String, dynamic> json) =>
      _$CourseReorderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CourseReorderRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class SectionReorderRequest {
  const SectionReorderRequest({required this.id, this.lessonIds});

  final int id;
  @JsonKey(name: 'lesson_ids')
  final List<int>? lessonIds;

  factory SectionReorderRequest.fromJson(Map<String, dynamic> json) =>
      _$SectionReorderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SectionReorderRequestToJson(this);
}
