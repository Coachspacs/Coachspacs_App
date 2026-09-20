import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/notifications/data/repo/notifications_repository.dart';
import 'package:coach_space/features/student/notifications/data/repo/notifications_repository_impl.dart';

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

NotificationsRepository _repositoryWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.httpClientAdapter = adapter;
  return NotificationsRepositoryImpl(apiService: ApiService(dio));
}

const _notificationJson = {
  'id': 7,
  'title': 'Welcome',
  'message': 'Thanks for joining',
  'type': 'system',
  'is_read': false,
  'created_at': '2026-01-04T00:00:00.000Z',
};

void main() {
  group('NotificationsRepositoryImpl.getNotifications', () {
    test('GETs api/notifications with pagination and parses the page', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'GET');
        expect(options.path, 'api/notifications');
        expect(options.queryParameters, {'page': 3, 'page_size': 10});
        return _json({
          'count': 21,
          'next': 'http://test.local/api/notifications?page=4',
          'previous': null,
          'results': [_notificationJson],
        }, 200);
      });

      final page = await _repositoryWith(
        adapter,
      ).getNotifications(page: 3, pageSize: 10);

      expect(page.count, 21);
      expect(page.next, contains('page=4'));
      expect(page.results.single.id, 7);
      expect(page.results.single.isRead, isFalse);
    });
  });

  group('NotificationsRepositoryImpl.markRead', () {
    test('POSTs api/notifications/{id}/read', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'POST');
        expect(options.path, 'api/notifications/7/read');
        return _json(<String, dynamic>{}, 200);
      });

      await _repositoryWith(adapter).markRead(7);

      expect(adapter.requests, hasLength(1));
    });

    test('maps a 404 to NetworkException.notFound', () async {
      final adapter = _MockAdapter(
        (options, all) async => _json({'detail': 'Not found.'}, 404),
      );

      expect(
        () => _repositoryWith(adapter).markRead(7),
        throwsA(
          isA<NetworkException>().having(
            (error) => error.kind,
            'kind',
            FailureKind.notFound,
          ),
        ),
      );
    });
  });

  group('NotificationsRepositoryImpl.markAllRead', () {
    test('POSTs api/notifications/read-all', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'POST');
        expect(options.path, 'api/notifications/read-all');
        return _json(<String, dynamic>{}, 200);
      });

      await _repositoryWith(adapter).markAllRead();

      expect(adapter.requests, hasLength(1));
    });

    test('maps a 401 to NetworkException.unauthorized', () async {
      final adapter = _MockAdapter(
        (options, all) async => _json({'detail': 'Unauthorized.'}, 401),
      );

      expect(
        () => _repositoryWith(adapter).markAllRead(),
        throwsA(
          isA<NetworkException>().having(
            (error) => error.kind,
            'kind',
            FailureKind.unauthorized,
          ),
        ),
      );
    });
  });
}
