import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository_impl.dart';

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

CartRepository _repositoryWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.httpClientAdapter = adapter;
  return CartRepositoryImpl(apiService: ApiService(dio));
}

const _cartItemJson = {
  'id': 3,
  'course': {
    'id': 5,
    'title': 'Flutter Basics',
    'cover_image': null,
    'price': '29.99',
    'status': 'published',
  },
  'is_available': true,
  'added_at': '2026-01-03T00:00:00.000Z',
};

const _cartJson = {
  'id': 1,
  'items': [_cartItemJson],
  'item_count': 1,
  'total': '29.99',
  'created_at': '2026-01-03T00:00:00.000Z',
};

void main() {
  group('CartRepositoryImpl.getCart', () {
    test('GETs api/cart and parses the response', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'GET');
        expect(options.path, 'api/cart');
        return _json(_cartJson, 200);
      });

      final cart = await _repositoryWith(adapter).getCart();

      expect(cart.id, 1);
      expect(cart.itemCount, 1);
      expect(cart.items, hasLength(1));
      expect(cart.items.single.id, 3);
      expect(cart.items.single.course.title, 'Flutter Basics');
      expect(cart.total, '29.99');
      expect(cart.isEmpty, isFalse);
    });

    test('maps a 404 to NetworkException.notFound', () async {
      final adapter = _MockAdapter(
        (options, all) async => _json({'detail': 'Not found.'}, 404),
      );

      expect(
        () => _repositoryWith(adapter).getCart(),
        throwsA(
          isA<NetworkException>()
              .having((error) => error.kind, 'kind', FailureKind.notFound)
              .having((error) => error.message, 'message', 'Not found.'),
        ),
      );
    });
  });

  group('CartRepositoryImpl.addItem', () {
    test('POSTs api/cart/items with the course id', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'POST');
        expect(options.path, 'api/cart/items');
        expect(_bodyOf(options), {'course_id': 5});
        return _json(<String, dynamic>{}, 200);
      });

      await _repositoryWith(adapter).addItem(5);

      expect(adapter.requests, hasLength(1));
    });

    test('succeeds when the API returns an empty body', () async {
      final adapter = _MockAdapter(
        (options, all) async => ResponseBody.fromString('', 200),
      );

      await _repositoryWith(adapter).addItem(5);

      expect(adapter.requests, hasLength(1));
    });

    test('parses field errors from a 400 response', () async {
      final adapter = _MockAdapter(
        (options, all) async =>
            _json({'course_id': ['This field is required.']}, 400),
      );

      expect(
        () => _repositoryWith(adapter).addItem(5),
        throwsA(
          isA<NetworkException>()
              .having((error) => error.kind, 'kind', FailureKind.validation)
              .having(
                (error) => error.fieldErrors['course_id'],
                'fieldErrors[course_id]',
                ['This field is required.'],
              )
              .having(
                (error) => error.message,
                'message',
                'This field is required.',
              ),
        ),
      );
    });
  });

  group('CartRepositoryImpl.removeItem', () {
    test('DELETEs api/cart/items/{id}', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'DELETE');
        expect(options.path, 'api/cart/items/3');
        return _json(<String, dynamic>{}, 200);
      });

      await _repositoryWith(adapter).removeItem(3);

      expect(adapter.requests, hasLength(1));
    });

    test('maps a 500 to NetworkException.serverError', () async {
      final adapter = _MockAdapter(
        (options, all) async => _json({'detail': 'Server error'}, 500),
      );

      expect(
        () => _repositoryWith(adapter).removeItem(3),
        throwsA(
          isA<NetworkException>().having(
            (error) => error.kind,
            'kind',
            FailureKind.serverError,
          ),
        ),
      );
    });
  });
}
