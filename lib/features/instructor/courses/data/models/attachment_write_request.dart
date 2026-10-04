import 'package:json_annotation/json_annotation.dart';

part 'attachment_write_request.g.dart';

/// Body for creating/updating an instructor attachment (US-21): the file is
/// uploaded directly to Cloudinary first, then registered by its public id.
@JsonSerializable(includeIfNull: false)
class AttachmentWriteRequest {
  const AttachmentWriteRequest({required this.fileName, required this.filePublicId});

  @JsonKey(name: 'file_name')
  final String fileName;

  @JsonKey(name: 'file_public_id')
  final String filePublicId;

  factory AttachmentWriteRequest.fromJson(Map<String, dynamic> json) =>
      _$AttachmentWriteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentWriteRequestToJson(this);
}
