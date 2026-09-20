import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/order_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/order_repository_impl.dart';

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

OrderRepository _repositoryWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.httpClientAdapter = adapter;
  return OrderRepositoryImpl(apiService: ApiService(dio));
}

Map<String, dynamic> _orderJson(int id) => {
  'id': id,
  'order_number': 'ORD-$id',
  'status': 'pending',
  'items': [
    {
      'id': 1,
      'course_id': 5,
      'course_title': 'Flutter Basics',
      'cover_image': '',
      'price': '29.99',
    },
  ],
  'subtotal': '29.99',
  'discount': '0.00',
  'tax': '0.00',
  'total': '29.99',
  'currency': 'USD',
  'payment_method': null,
  'created_at': '2026-01-03T00:00:00.000Z',
  'paid_at': null,
};

void main() {
  group('OrderRepositoryImpl.createOrder', () {
    test('POSTs api/orders with the coupon code', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'POST');
        expect(options.path, 'api/orders');
        expect(_bodyOf(options), {'coupon_code': 'X'});
        return _json(_orderJson(1), 201);
      });

      final order = await _repositoryWith(adapter).createOrder(couponCode: 'X');

      expect(order.id, 1);
      expect(order.orderNumber, 'ORD-1');
      expect(order.status, OrderStatus.pending);
      expect(order.items.single.courseTitle, 'Flutter Basics');
      expect(order.total, '29.99');
    });

    test('omits coupon_code when none is supplied', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.path, 'api/orders');
        expect(_bodyOf(options), <String, dynamic>{});
        return _json(_orderJson(2), 201);
      });

      final order = await _repositoryWith(adapter).createOrder();

      expect(order.id, 2);
    });

    test('maps a 422 to NetworkException.businessRejection', () async {
      final adapter = _MockAdapter(
        (options, all) async =>
            _json({'detail': 'Cart is empty.'}, 422),
      );

      expect(
        () => _repositoryWith(adapter).createOrder(),
        throwsA(
          isA<NetworkException>()
              .having(
                (error) => error.kind,
                'kind',
                FailureKind.businessRejection,
              )
              .having((error) => error.message, 'message', 'Cart is empty.'),
        ),
      );
    });
  });

  group('OrderRepositoryImpl.getOrders', () {
    test('GETs api/orders with pagination and parses the page', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'GET');
        expect(options.path, 'api/orders');
        expect(options.queryParameters, {'page': 2, 'page_size': 5});
        return _json({
          'count': 6,
          'next': null,
          'previous': 'http://test.local/api/orders?page=1',
          'results': [_orderJson(6)],
        }, 200);
      });

      final page = await _repositoryWith(
        adapter,
      ).getOrders(page: 2, pageSize: 5);

      expect(page.count, 6);
      expect(page.results.single.id, 6);
      expect(page.previous, contains('page=1'));
    });
  });

  group('OrderRepositoryImpl.getOrder', () {
    test('GETs api/orders/{id}', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'GET');
        expect(options.path, 'api/orders/9');
        return _json(_orderJson(9), 200);
      });

      final order = await _repositoryWith(adapter).getOrder(9);

      expect(order.id, 9);
    });
  });
}
