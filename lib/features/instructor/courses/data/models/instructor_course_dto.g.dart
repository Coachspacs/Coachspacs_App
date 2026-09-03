// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_course_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorCourseDto _$InstructorCourseDtoFromJson(Map<String, dynamic> json) =>
    InstructorCourseDto(
      id: (json['id'] as num).toInt(),
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      descriptionAr: json['description_ar'] as String,
      descriptionEn: json['description_en'] as String,
      category: (json['category'] as num).toInt(),
      level: json['level'] as String,
      language: json['language'] as String,
      price: json['price'] as String,
      status: json['status'] as String,
      coverImage: json['cover_image'] as String? ?? '',
      rejectionReason: json['rejection_reason'] as String?,
      sections:
          (json['sections'] as List<dynamic>?)
              ?.map(
                (e) => InstructorSectionDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$InstructorCourseDtoToJson(
  InstructorCourseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title_ar': instance.titleAr,
  'title_en': instance.titleEn,
  'description_ar': instance.descriptionAr,
  'description_en': instance.descriptionEn,
  'category': instance.category,
  'level': instance.level,
  'language': instance.language,
  'price': instance.price,
  'status': instance.status,
  'cover_image': instance.coverImage,
  'rejection_reason': instance.rejectionReason,
  'sections': instance.sections.map((e) => e.toJson()).toList(),
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

InstructorSectionDto _$InstructorSectionDtoFromJson(
  Map<String, dynamic> json,
) => InstructorSectionDto(
  id: (json['id'] as num).toInt(),
  titleAr: json['title_ar'] as String,
  titleEn: json['title_en'] as String,
  order: (json['order'] as num).toInt(),
  lessons:
      (json['lessons'] as List<dynamic>?)
          ?.map((e) => InstructorLessonDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$InstructorSectionDtoToJson(
  InstructorSectionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title_ar': instance.titleAr,
  'title_en': instance.titleEn,
  'order': instance.order,
  'lessons': instance.lessons.map((e) => e.toJson()).toList(),
};

InstructorLessonDto _$InstructorLessonDtoFromJson(Map<String, dynamic> json) =>
    InstructorLessonDto(
      id: (json['id'] as num).toInt(),
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      isPreview: json['is_preview'] as bool,
      videoUrl: json['video_url'] as String? ?? '',
    );

Map<String, dynamic> _$InstructorLessonDtoToJson(
  InstructorLessonDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title_ar': instance.titleAr,
  'title_en': instance.titleEn,
  'video_url': instance.videoUrl,
  'duration_minutes': instance.durationMinutes,
  'order': instance.order,
  'is_preview': instance.isPreview,
};

CourseWriteRequest _$CourseWriteRequestFromJson(Map<String, dynamic> json) =>
    CourseWriteRequest(
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      descriptionAr: json['description_ar'] as String,
      descriptionEn: json['description_en'] as String,
      category: (json['category'] as num).toInt(),
      level: json['level'] as String,
      language: json['language'] as String,
      price: json['price'] as String,
    );

Map<String, dynamic> _$CourseWriteRequestToJson(CourseWriteRequest instance) =>
    <String, dynamic>{
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'description_ar': instance.descriptionAr,
      'description_en': instance.descriptionEn,
      'category': instance.category,
      'level': instance.level,
      'language': instance.language,
      'price': instance.price,
    };

CoursePatchRequest _$CoursePatchRequestFromJson(Map<String, dynamic> json) =>
    CoursePatchRequest(
      titleAr: json['title_ar'] as String?,
      titleEn: json['title_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      category: (json['category'] as num?)?.toInt(),
      level: json['level'] as String?,
      language: json['language'] as String?,
      price: json['price'] as String?,
    );

Map<String, dynamic> _$CoursePatchRequestToJson(CoursePatchRequest instance) =>
    <String, dynamic>{
      'title_ar': ?instance.titleAr,
      'title_en': ?instance.titleEn,
      'description_ar': ?instance.descriptionAr,
      'description_en': ?instance.descriptionEn,
      'category': ?instance.category,
      'level': ?instance.level,
      'language': ?instance.language,
      'price': ?instance.price,
    };

SectionWriteRequest _$SectionWriteRequestFromJson(Map<String, dynamic> json) =>
    SectionWriteRequest(
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$SectionWriteRequestToJson(
  SectionWriteRequest instance,
) => <String, dynamic>{
  'title_ar': instance.titleAr,
  'title_en': instance.titleEn,
  'order': instance.order,
};

SectionPatchRequest _$SectionPatchRequestFromJson(Map<String, dynamic> json) =>
    SectionPatchRequest(
      titleAr: json['title_ar'] as String?,
      titleEn: json['title_en'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SectionPatchRequestToJson(
  SectionPatchRequest instance,
) => <String, dynamic>{
  'title_ar': ?instance.titleAr,
  'title_en': ?instance.titleEn,
  'order': ?instance.order,
};

LessonWriteRequest _$LessonWriteRequestFromJson(Map<String, dynamic> json) =>
    LessonWriteRequest(
      titleAr: json['title_ar'] as String,
      titleEn: json['title_en'] as String,
      videoUrl: json['video_url'] as String,
      videoPublicId: json['video_public_id'] as String,
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      order: (json['order'] as num).toInt(),
      isPreview: json['is_preview'] as bool,
    );

Map<String, dynamic> _$LessonWriteRequestToJson(LessonWriteRequest instance) =>
    <String, dynamic>{
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'video_url': instance.videoUrl,
      'video_public_id': instance.videoPublicId,
      'duration_minutes': instance.durationMinutes,
      'order': instance.order,
      'is_preview': instance.isPreview,
    };

LessonPatchRequest _$LessonPatchRequestFromJson(Map<String, dynamic> json) =>
    LessonPatchRequest(
      titleAr: json['title_ar'] as String?,
      titleEn: json['title_en'] as String?,
      videoUrl: json['video_url'] as String?,
      videoPublicId: json['video_public_id'] as String?,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt(),
      isPreview: json['is_preview'] as bool?,
    );

Map<String, dynamic> _$LessonPatchRequestToJson(LessonPatchRequest instance) =>
    <String, dynamic>{
      'title_ar': ?instance.titleAr,
      'title_en': ?instance.titleEn,
      'video_url': ?instance.videoUrl,
      'video_public_id': ?instance.videoPublicId,
      'duration_minutes': ?instance.durationMinutes,
      'order': ?instance.order,
      'is_preview': ?instance.isPreview,
    };

CourseReorderRequest _$CourseReorderRequestFromJson(
  Map<String, dynamic> json,
) => CourseReorderRequest(
  sections: (json['sections'] as List<dynamic>)
      .map((e) => SectionReorderRequest.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CourseReorderRequestToJson(
  CourseReorderRequest instance,
) => <String, dynamic>{
  'sections': instance.sections.map((e) => e.toJson()).toList(),
};

SectionReorderRequest _$SectionReorderRequestFromJson(
  Map<String, dynamic> json,
) => SectionReorderRequest(
  id: (json['id'] as num).toInt(),
  lessonIds: (json['lesson_ids'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$SectionReorderRequestToJson(
  SectionReorderRequest instance,
) => <String, dynamic>{'id': instance.id, 'lesson_ids': ?instance.lessonIds};
