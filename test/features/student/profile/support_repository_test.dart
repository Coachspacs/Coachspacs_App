import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/repo/support_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/support_repository_impl.dart';

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

SupportRepository _repositoryWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.httpClientAdapter = adapter;
  return SupportRepositoryImpl(apiService: ApiService(dio));
}

void main() {
  group('SupportRepositoryImpl.sendContactMessage', () {
    test('POSTs api/support/contact with message, subject and category', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'POST');
        expect(options.path, 'api/support/contact');
        expect(_bodyOf(options), {
          'message': 'I need help',
          'subject': 'Billing',
          'category': 'payment',
        });
        return _json(<String, dynamic>{}, 201);
      });

      await _repositoryWith(adapter).sendContactMessage(
        message: 'I need help',
        subject: 'Billing',
        category: 'payment',
      );

      expect(adapter.requests, hasLength(1));
    });

    test('defaults subject and category to empty strings', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(_bodyOf(options), {
          'message': 'Hello',
          'subject': '',
          'category': '',
        });
        return _json(<String, dynamic>{}, 201);
      });

      await _repositoryWith(adapter).sendContactMessage(message: 'Hello');
    });

    test('maps a 500 to NetworkException.serverError', () async {
      final adapter = _MockAdapter(
        (options, all) async =>
            _json({'detail': 'Support is down'}, 500),
      );

      expect(
        () => _repositoryWith(
          adapter,
        ).sendContactMessage(message: 'Hello'),
        throwsA(
          isA<NetworkException>()
              .having(
                (error) => error.kind,
                'kind',
                FailureKind.serverError,
              )
              .having(
                (error) => error.message,
                'message',
                'Support is down',
              ),
        ),
      );
    });
  });
}
