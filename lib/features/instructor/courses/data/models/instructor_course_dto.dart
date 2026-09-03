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

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  const PaginatedResponse({required this.count, required this.results});
  final int count;
  final List<T> results;
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseFromJson(json, fromJsonT);
}
