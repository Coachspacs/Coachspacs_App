import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/helpers/media_url.dart';
import 'package:coach_space/core/networking/api_client.dart';

void main() {
  group('resolveMediaUrl', () {
    test('returns empty string for null/blank input', () {
      expect(resolveMediaUrl(null), '');
      expect(resolveMediaUrl(''), '');
      expect(resolveMediaUrl('   '), '');
    });

    test('keeps absolute http(s) URLs as-is', () {
      const url = 'https://res.cloudinary.com/x/image/upload/a.jpg';
      expect(resolveMediaUrl(url), url);
      expect(resolveMediaUrl('http://example.com/a.jpg'), 'http://example.com/a.jpg');
    });

    test('upgrades protocol-relative URLs to https', () {
      expect(resolveMediaUrl('//cdn.example.com/a.jpg'), 'https://cdn.example.com/a.jpg');
    });

    test('prefixes absolute-path media with the API base URL', () {
      final resolved = resolveMediaUrl('/media/avatars/user_1.jpg');
      expect(resolved, startsWith(ApiClient.baseUrl.split('/').first));
      expect(resolved, contains('/media/avatars/user_1.jpg'));
      expect(resolved, startsWith('https://'));
    });

    test('prefixes relative paths with the API base URL', () {
      final resolved = resolveMediaUrl('media/avatars/user_1.jpg');
      expect(resolved, startsWith('https://'));
      expect(resolved, contains('media/avatars/user_1.jpg'));
    });
  });
}
