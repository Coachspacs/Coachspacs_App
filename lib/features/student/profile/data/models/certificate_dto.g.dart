// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateDto _$CertificateDtoFromJson(Map<String, dynamic> json) =>
    CertificateDto(
      id: (json['id'] as num).toInt(),
      certificateCode: json['certificate_code'] as String? ?? '',
      studentFullName: json['student_full_name'] as String? ?? '',
      courseTitle: json['course_title'] as String? ?? '',
      instructorFullName: json['instructor_full_name'] as String? ?? '',
      issuedAt: DateTime.parse(json['issued_at'] as String),
    );

Map<String, dynamic> _$CertificateDtoToJson(CertificateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'certificate_code': instance.certificateCode,
      'student_full_name': instance.studentFullName,
      'course_title': instance.courseTitle,
      'instructor_full_name': instance.instructorFullName,
      'issued_at': instance.issuedAt.toIso8601String(),
    };
