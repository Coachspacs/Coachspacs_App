// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateDetailDto _$CertificateDetailDtoFromJson(
  Map<String, dynamic> json,
) => CertificateDetailDto(
  id: (json['id'] as num).toInt(),
  certificateCode: json['certificate_code'] as String? ?? '',
  studentFullName: json['student_full_name'] as String? ?? '',
  courseTitle: json['course_title'] as String? ?? '',
  instructorFullName: json['instructor_full_name'] as String? ?? '',
  issuedAt: json['issued_at'] as String?,
);

Map<String, dynamic> _$CertificateDetailDtoToJson(
  CertificateDetailDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'certificate_code': instance.certificateCode,
  'student_full_name': instance.studentFullName,
  'course_title': instance.courseTitle,
  'instructor_full_name': instance.instructorFullName,
  'issued_at': instance.issuedAt,
};
