// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateDto _$CertificateDtoFromJson(Map<String, dynamic> json) =>
    CertificateDto(
      id: (json['id'] as num).toInt(),
      certificateNumber: json['certificate_number'] as String,
      course: CertificateCourseDto.fromJson(
        json['course'] as Map<String, dynamic>,
      ),
      studentName: json['student_name'] as String,
      issuedAt: DateTime.parse(json['issued_at'] as String),
      instructorName: json['instructor_name'] as String?,
      downloadUrl: json['download_url'] as String?,
    );

Map<String, dynamic> _$CertificateDtoToJson(CertificateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'certificate_number': instance.certificateNumber,
      'course': instance.course.toJson(),
      'student_name': instance.studentName,
      'instructor_name': instance.instructorName,
      'issued_at': instance.issuedAt.toIso8601String(),
      'download_url': instance.downloadUrl,
    };

CertificateCourseDto _$CertificateCourseDtoFromJson(
  Map<String, dynamic> json,
) => CertificateCourseDto(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  coverImage: json['cover_image'] as String,
);

Map<String, dynamic> _$CertificateCourseDtoToJson(
  CertificateCourseDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'cover_image': instance.coverImage,
};
