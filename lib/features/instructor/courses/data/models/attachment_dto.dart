import 'package:json_annotation/json_annotation.dart';

part 'attachment_dto.g.dart';

/// Attachment row as returned by the instructor attachment endpoints and the
/// course-materials endpoints (US-21).
@JsonSerializable()
class AttachmentDto {
  const AttachmentDto({
    required this.id,
    this.fileName = '',
    this.fileType = '',
    this.fileSize = 0,
    this.createdAt,
    this.downloadUrl,
  });

  final int id;

  @JsonKey(name: 'file_name', defaultValue: '')
  final String fileName;

  @JsonKey(name: 'file_type', defaultValue: '')
  final String fileType;

  @JsonKey(name: 'file_size', defaultValue: 0)
  final int fileSize;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'download_url')
  final String? downloadUrl;

  factory AttachmentDto.fromJson(Map<String, dynamic> json) =>
      _$AttachmentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentDtoToJson(this);
}
