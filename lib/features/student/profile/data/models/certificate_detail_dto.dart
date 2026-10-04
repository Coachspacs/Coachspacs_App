import 'package:json_annotation/json_annotation.dart';

part 'certificate_detail_dto.g.dart';

/// `GET /api/certificates/{id}` response (US-16 scenario 2) — everything the
/// frontend needs to render one certificate. The backend never generates a
/// certificate image/PDF; the client renders its own from these fields.
@JsonSerializable()
class CertificateDetailDto {
  const CertificateDetailDto({
    required this.id,
    this.certificateCode = '',
    this.studentFullName = '',
    this.courseTitle = '',
    this.instructorFullName = '',
    this.issuedAt,
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
  final String? issuedAt;

  factory CertificateDetailDto.fromJson(Map<String, dynamic> json) =>
      _$CertificateDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CertificateDetailDtoToJson(this);
}
