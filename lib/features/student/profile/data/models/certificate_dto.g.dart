// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CertificateDto _$CertificateDtoFromJson(Map<String, dynamic> json) =>
    CertificateDto(
      id: (json['id'] as num).toInt(),
      certificateCode: json['certificate_code'] as String? ?? '',
      pdfUrl: json['pdf_url'] as String? ?? '',
      issuedAt: DateTime.parse(json['issued_at'] as String),
    );

Map<String, dynamic> _$CertificateDtoToJson(CertificateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'certificate_code': instance.certificateCode,
      'pdf_url': instance.pdfUrl,
      'issued_at': instance.issuedAt.toIso8601String(),
    };
