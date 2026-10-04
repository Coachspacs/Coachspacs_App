import 'dart:io';

import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/instructor/courses/data/models/upload_signature_dto.dart';

/// Result of a successful direct-to-Cloudinary upload: identifies the stored
/// asset so the backend can register it by its public id (US-21).
class CloudinaryUploadResult {
  const CloudinaryUploadResult({
    required this.publicId,
    required this.url,
    this.sizeBytes,
  });

  /// Cloudinary public id — the value the backend stores on the attachment.
  final String publicId;

  /// `secure_url` reported by Cloudinary, when present.
  final String url;

  final int? sizeBytes;
}

/// Uploads attachment files directly to Cloudinary using the folder-scoped,
/// short-lived signature handed out by
/// `POST /api/instructor/courses/{id}/attachment-upload-signature` (US-21).
///
/// The upload must not carry the app's auth interceptors, so a bare [Dio] is
/// created internally — the backend never sees Cloudinary traffic, and the
/// app token never reaches Cloudinary.
class AttachmentCloudinaryUploader {
  AttachmentCloudinaryUploader({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  /// Uploads [file] and reports progress fractions (0..1) through
  /// [onProgress] when the content length is known.
  Future<CloudinaryUploadResult> upload(
    UploadSignatureDto signature, {
    required File file,
    required String fileName,
    void Function(double progress)? onProgress,
  }) async {
    if (signature.signature.isEmpty || signature.timestamp.isEmpty) {
      throw const NetworkException(
        kind: FailureKind.unknown,
        message: 'Upload is not available right now. Please try again later.',
      );
    }

    final uploadUrl = _resolveUploadUrl(signature);

    // Signed uploads only accept the parameters the signature covers; sending
    // anything else makes Cloudinary reject the request.
    final fields = <String, String>{
      'api_key': signature.apiKey ?? '',
      'timestamp': signature.timestamp,
      'signature': signature.signature,
    };
    if (signature.folder?.isNotEmpty ?? false) {
      fields['folder'] = signature.folder!;
    }
    if (signature.publicId?.isNotEmpty ?? false) {
      fields['public_id'] = signature.publicId!;
    }

    final data = FormData.fromMap({
      ...fields,
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await _dio.post<dynamic>(
      uploadUrl,
      data: data,
      onSendProgress: (sent, total) {
        if (total > 0 && onProgress != null) {
          onProgress((sent / total).clamp(0.0, 1.0));
        }
      },
    );

    final body = response.data;
    if (body is! Map) {
      throw const NetworkException(
        kind: FailureKind.serverError,
        message: 'Upload failed. Please try again.',
      );
    }

    final publicId = (body['public_id'] ?? signature.publicId ?? '')
        .toString()
        .trim();
    final url = (body['secure_url'] ?? body['url'] ?? '').toString().trim();
    if (publicId.isEmpty) {
      throw const NetworkException(
        kind: FailureKind.serverError,
        message: 'Upload failed. Please try again.',
      );
    }

    return CloudinaryUploadResult(
      publicId: publicId,
      url: url,
      sizeBytes: await file.length(),
    );
  }

  String _resolveUploadUrl(UploadSignatureDto signature) {
    final provided = signature.uploadUrl;
    if (provided != null && provided.isNotEmpty) return provided;

    final cloudName = signature.cloudName;
    if (cloudName != null && cloudName.isNotEmpty) {
      return 'https://api.cloudinary.com/v1_1/$cloudName/auto/upload';
    }

    throw const NetworkException(
      kind: FailureKind.unknown,
      message: 'Upload is not available right now. Please try again later.',
    );
  }
}
