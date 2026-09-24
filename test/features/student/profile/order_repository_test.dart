import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
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

OrderRepository _repositoryWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.httpClientAdapter = adapter;
  return OrderRepositoryImpl(apiService: ApiService(dio));
}

Map<String, dynamic> _orderJson(int id) => {
  'id': id,
  'status': 'pending',
  'total_amount': '29.99',
  'items': [
    {
      'id': 1,
      'course': {
        'id': 5,
        'title': 'Flutter Basics',
        'price': '29.99',
        'cover_image': '',
        'status': 'published',
      },
      'price_at_purchase': '29.99',
    },
  ],
  'created_at': '2026-01-03T00:00:00.000Z',
};

void main() {
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
}
