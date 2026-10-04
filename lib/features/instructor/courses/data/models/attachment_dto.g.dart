// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentDto _$AttachmentDtoFromJson(Map<String, dynamic> json) =>
    AttachmentDto(
      id: (json['id'] as num).toInt(),
      fileName: json['file_name'] as String? ?? '',
      fileType: json['file_type'] as String? ?? '',
      fileSize: (json['file_size'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] as String?,
      downloadUrl: json['download_url'] as String?,
    );

Map<String, dynamic> _$AttachmentDtoToJson(AttachmentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file_name': instance.fileName,
      'file_type': instance.fileType,
      'file_size': instance.fileSize,
      'created_at': instance.createdAt,
      'download_url': instance.downloadUrl,
    };
