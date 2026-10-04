/// `POST /api/instructor/courses/{id}/video-upload-signature` and
/// `.../attachment-upload-signature` response.
///
/// Hands the frontend a short-lived, folder-scoped Cloudinary signature so it
/// can upload the file directly to Cloudinary. The response schema is not
/// pinned down by the OpenAPI document, so parsing is lenient.
class UploadSignatureDto {
  const UploadSignatureDto({
    required this.signature,
    required this.timestamp,
    this.apiKey,
    this.folder,
    this.cloudName,
    this.uploadUrl,
    this.publicId,
  });

  final String signature;
  final String timestamp;
  final String? apiKey;
  final String? folder;
  final String? cloudName;
  final String? uploadUrl;
  final String? publicId;

  factory UploadSignatureDto.fromJson(Map<String, dynamic> json) {
    Object? first(List<String> keys) {
      for (final key in keys) {
        final value = json[key];
        if (value != null && value.toString().isNotEmpty) return value;
      }
      return null;
    }

    return UploadSignatureDto(
      signature: (first(const ['signature']) ?? '').toString(),
      timestamp: (first(const ['timestamp']) ?? '').toString(),
      apiKey: first(const ['api_key', 'apiKey'])?.toString(),
      folder: first(const ['folder'])?.toString(),
      cloudName:
          first(const ['cloud_name', 'cloudName', 'cloud'])?.toString(),
      uploadUrl:
          first(const ['upload_url', 'uploadUrl', 'url'])?.toString(),
      publicId: first(const ['public_id', 'publicId'])?.toString(),
    );
  }
}
