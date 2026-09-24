import 'package:json_annotation/json_annotation.dart';

part 'certificate_dto.g.dart';

/// `GET /api/certificates` item.
@JsonSerializable()
class CertificateDto {
  const CertificateDto({
    required this.id,
    required this.certificateCode,
    this.pdfUrl = '',
    required this.issuedAt,
  });

  final int id;
  @JsonKey(name: 'certificate_code', defaultValue: '')
  final String certificateCode;
  @JsonKey(name: 'pdf_url', defaultValue: '')
  final String pdfUrl;
  @JsonKey(name: 'issued_at')
  final DateTime issuedAt;

  factory CertificateDto.fromJson(Map<String, dynamic> json) =>
      _$CertificateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CertificateDtoToJson(this);
}
