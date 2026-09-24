import 'package:coach_space/core/networking/api_client.dart';

/// Resolves a media path returned by the API into an absolute URL that
/// [Image.network] can load.
///
/// - Absolute `http(s)` URLs are returned as-is.
/// - Protocol-relative (`//host/...`) URLs get an `https:` scheme.
/// - Relative paths (`/media/...`, `media/...`) are resolved against
///   [ApiClient.baseUrl].
/// - `null`/blank input yields `''` so callers can fall back to initials.
String resolveMediaUrl(String? url) {
  final raw = url?.trim() ?? '';
  if (raw.isEmpty) return '';

  if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
  if (raw.startsWith('//')) return 'https:$raw';

  final base = ApiClient.baseUrl.endsWith('/')
      ? ApiClient.baseUrl
      : '${ApiClient.baseUrl}/';

  if (raw.startsWith('/')) {
    final baseUri = Uri.parse(ApiClient.baseUrl);
    return baseUri.replace(path: raw).toString();
  }

  return '$base$raw';
}
