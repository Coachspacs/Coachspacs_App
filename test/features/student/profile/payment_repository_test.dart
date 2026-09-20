import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/repo/payment_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/payment_repository_impl.dart';

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

PaymentRepository _repositoryWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.httpClientAdapter = adapter;
  return PaymentRepositoryImpl(apiService: ApiService(dio));
}

const _intentJson = {
  'id': 8,
  'order_id': 4,
  'provider': 'stripe',
  'status': 'requires_payment_method',
  'amount': '29.99',
  'currency': 'USD',
  'client_secret': 'secret',
  'publishable_key': 'pk_test',
};

void main() {
  group('PaymentRepositoryImpl.createIntent', () {
    test('POSTs api/payments/intent with order id and provider', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'POST');
        expect(options.path, 'api/payments/intent');
        expect(_bodyOf(options), {'order_id': 4, 'provider': 'stripe'});
        return _json(_intentJson, 201);
      });

      final intent = await _repositoryWith(
        adapter,
      ).createIntent(orderId: 4, provider: 'stripe');

      expect(intent.id, 8);
      expect(intent.orderId, 4);
      expect(intent.provider, 'stripe');
      expect(intent.clientSecret, 'secret');
      expect(intent.publishableKey, 'pk_test');
      expect(intent.isSucceeded, isFalse);
    });

    test('sends a successful manual intent', () async {
      final adapter = _MockAdapter(
        (options, all) async => _json({
          ..._intentJson,
          'provider': 'manual',
          'status': 'succeeded',
        }, 200),
      );

      final intent = await _repositoryWith(
        adapter,
      ).createIntent(orderId: 4);

      expect(intent.provider, 'manual');
      expect(intent.isSucceeded, isTrue);
    });

    test('maps a 409 to NetworkException.conflict', () async {
      final adapter = _MockAdapter(
        (options, all) async =>
            _json({'detail': 'Payment already in progress.'}, 409),
      );

      expect(
        () => _repositoryWith(adapter).createIntent(orderId: 4),
        throwsA(
          isA<NetworkException>()
              .having((error) => error.kind, 'kind', FailureKind.conflict)
              .having(
                (error) => error.message,
                'message',
                'Payment already in progress.',
              ),
        ),
      );
    });
  });
}
