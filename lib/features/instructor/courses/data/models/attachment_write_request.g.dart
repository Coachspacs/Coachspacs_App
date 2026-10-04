// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_write_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttachmentWriteRequest _$AttachmentWriteRequestFromJson(
  Map<String, dynamic> json,
) => AttachmentWriteRequest(
  fileName: json['file_name'] as String,
  filePublicId: json['file_public_id'] as String,
);

Map<String, dynamic> _$AttachmentWriteRequestToJson(
  AttachmentWriteRequest instance,
) => <String, dynamic>{
  'file_name': instance.fileName,
  'file_public_id': instance.filePublicId,
};
