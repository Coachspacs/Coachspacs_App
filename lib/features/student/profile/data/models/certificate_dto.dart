import 'package:json_annotation/json_annotation.dart';

part 'certificate_dto.g.dart';

/// `GET /api/certificates` item.
@JsonSerializable(explicitToJson: true)
class CertificateDto {
  const CertificateDto({
    required this.id,
    required this.certificateNumber,
    required this.course,
    required this.studentName,
    required this.issuedAt,
    this.instructorName,
    this.downloadUrl,
  });

  final int id;
  @JsonKey(name: 'certificate_number')
  final String certificateNumber;
  final CertificateCourseDto course;
  @JsonKey(name: 'student_name')
  final String studentName;
  @JsonKey(name: 'instructor_name')
  final String? instructorName;
  @JsonKey(name: 'issued_at')
  final DateTime issuedAt;
  @JsonKey(name: 'download_url')
  final String? downloadUrl;

  factory CertificateDto.fromJson(Map<String, dynamic> json) =>
      _$CertificateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CertificateDtoToJson(this);
}

@JsonSerializable()
class CertificateCourseDto {
  const CertificateCourseDto({
    required this.id,
    required this.title,
    required this.coverImage,
  });

  final int id;
  final String title;
  @JsonKey(name: 'cover_image')
  final String coverImage;

  factory CertificateCourseDto.fromJson(Map<String, dynamic> json) =>
      _$CertificateCourseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CertificateCourseDtoToJson(this);
}
