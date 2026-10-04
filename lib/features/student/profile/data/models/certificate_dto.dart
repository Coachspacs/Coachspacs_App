import 'package:json_annotation/json_annotation.dart';

part 'certificate_dto.g.dart';

/// `GET /api/certificates` item (US-16).
@JsonSerializable()
class CertificateDto {
  const CertificateDto({
    required this.id,
    this.certificateCode = '',
    this.studentFullName = '',
    this.courseTitle = '',
    this.instructorFullName = '',
    required this.issuedAt,
  });

  final int id;

  @JsonKey(name: 'certificate_code', defaultValue: '')
  final String certificateCode;

  @JsonKey(name: 'student_full_name', defaultValue: '')
  final String studentFullName;

  @JsonKey(name: 'course_title', defaultValue: '')
  final String courseTitle;

  @JsonKey(name: 'instructor_full_name', defaultValue: '')
  final String instructorFullName;

  @JsonKey(name: 'issued_at')
  final DateTime issuedAt;

  factory CertificateDto.fromJson(Map<String, dynamic> json) =>
      _$CertificateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CertificateDtoToJson(this);
}
