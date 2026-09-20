import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/repo/preferences_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/preferences_repository_impl.dart';

class _MockAdapter implements HttpClientAdapter {
  _MockAdapter(this._handler);

  final Future<ResponseBody> Function(
    RequestOptions options,
    List<RequestOptions> all,
  )
  _handler;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return _handler(options, requests);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Object data, int status) => ResponseBody.fromString(
  jsonEncode(data),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

Object? _bodyOf(RequestOptions options) =>
    options.data is String ? jsonDecode(options.data as String) : options.data;

PreferencesRepository _repositoryWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.httpClientAdapter = adapter;
  return PreferencesRepositoryImpl(apiService: ApiService(dio));
}

const _prefsJson = {
  'learning_goal': 'Career switch',
  'field_of_interest': 'Development',
  'certificate_name': 'Jane Doe',
  'playback_speed': '1.0',
  'public_profile': true,
  'email_notifications': false,
  'push_notifications': true,
  'language': 'ar',
  'theme': 'dark',
};

void main() {
  group('PreferencesRepositoryImpl.getPreferences', () {
    test('GETs api/users/me/preferences and parses the response', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'GET');
        expect(options.path, 'api/users/me/preferences');
        return _json(_prefsJson, 200);
      });

      final prefs = await _repositoryWith(adapter).getPreferences();

      expect(prefs.learningGoal, 'Career switch');
      expect(prefs.publicProfile, isTrue);
      expect(prefs.emailNotifications, isFalse);
      expect(prefs.language, 'ar');
      expect(prefs.theme, 'dark');
    });
  });

  group('PreferencesRepositoryImpl.updatePreferences', () {
    test('PATCHes api/users/me/preferences with the supplied fields', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'PATCH');
        expect(options.path, 'api/users/me/preferences');
        expect(_bodyOf(options), {
          'email_notifications': false,
          'push_notifications': true,
          'language': 'ar',
          'theme': 'dark',
        });
        return _json(_prefsJson, 200);
      });

      final prefs = await _repositoryWith(adapter).updatePreferences(
        emailNotifications: false,
        pushNotifications: true,
        language: 'ar',
        theme: 'dark',
      );

      expect(prefs.language, 'ar');
      expect(prefs.emailNotifications, isFalse);
    });

    test('parses field errors from a 400 response', () async {
      final adapter = _MockAdapter(
        (options, all) async =>
            _json({'language': ['Unsupported language.']}, 400),
      );

      expect(
        () => _repositoryWith(adapter).updatePreferences(language: 'xx'),
        throwsA(
          isA<NetworkException>()
              .having((error) => error.kind, 'kind', FailureKind.validation)
              .having(
                (error) => error.fieldErrors['language'],
                'fieldErrors[language]',
                ['Unsupported language.'],
              ),
        ),
      );
    });
  });
}
