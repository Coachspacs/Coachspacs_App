import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';
import 'package:coach_space/features/student/profile/data/models/payment_intent_dto.dart';
import 'package:coach_space/features/student/profile/data/models/preferences_dto.dart';
import 'package:coach_space/features/student/profile/data/models/support_contact_request.dart';

ApiService _apiResolving(Object? data, List<RequestOptions> log) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        log.add(options);
        handler.resolve(
          Response(requestOptions: options, statusCode: 200, data: data),
        );
      },
    ),
  );
  return ApiService(dio);
}

const _cartJson = {
  'id': 1,
  'items': <Object?>[],
  'item_count': 0,
  'subtotal': '0.00',
  'discount': '0.00',
  'total': '0.00',
};

const _cartItemJson = {
  'id': 3,
  'course': {
    'id': 5,
    'title': 'Flutter Basics',
    'cover_image': '',
    'instructor': {'id': 9, 'full_name': 'Coach'},
    'price': '29.99',
    'is_free': false,
  },
  'price': '29.99',
};

const _orderJson = {
  'id': 1,
  'order_number': 'ORD-1',
  'status': 'pending',
  'items': <Object?>[],
  'subtotal': '29.99',
  'discount': '0.00',
  'tax': '0.00',
  'total': '29.99',
  'currency': 'USD',
  'created_at': '2026-01-03T00:00:00.000Z',
};

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

const _prefsJson = {
  'learning_goal': '',
  'field_of_interest': '',
  'certificate_name': '',
  'playback_speed': '1.0',
  'public_profile': true,
  'email_notifications': false,
  'push_notifications': true,
  'language': 'ar',
  'theme': 'dark',
};

void main() {
  test('cart GET calls api/cart', () async {
    final log = <RequestOptions>[];

    final cart = await _apiResolving(_cartJson, log).getCart();

    expect(cart.itemCount, 0);
    expect(cart.isEmpty, isTrue);
    expect(log.single.method, 'GET');
    expect(log.single.path, 'api/cart');
  });

  test('cart item POST calls api/cart/items with the course id', () async {
    final log = <RequestOptions>[];

    final item = await _apiResolving(
      _cartItemJson,
      log,
    ).addCartItem(const AddCartItemRequest(courseId: 5));

    expect(item.course.id, 5);
    expect(log.single.method, 'POST');
    expect(log.single.path, 'api/cart/items');
    expect(log.single.data, {'course_id': 5});
  });

  test('order POST calls api/orders with the coupon code', () async {
    final log = <RequestOptions>[];

    final order = await _apiResolving(
      _orderJson,
      log,
    ).createOrder(const CreateOrderRequest(couponCode: 'X'));

    expect(order.orderNumber, 'ORD-1');
    expect(log.single.method, 'POST');
    expect(log.single.path, 'api/orders');
    expect(log.single.data, {'coupon_code': 'X'});
  });

  test('payment intent POST calls api/payments/intent', () async {
    final log = <RequestOptions>[];

    final intent = await _apiResolving(_intentJson, log).createPaymentIntent(
      const CreatePaymentIntentRequest(orderId: 4, provider: 'stripe'),
    );

    expect(intent.orderId, 4);
    expect(log.single.method, 'POST');
    expect(log.single.path, 'api/payments/intent');
    expect(log.single.data, {'order_id': 4, 'provider': 'stripe'});
  });

  test('certificate download requests the bytes response type', () async {
    final log = <RequestOptions>[];
    const bytes = [37, 80, 68, 70];

    final result = await _apiResolving(
      bytes,
      log,
    ).downloadCertificate(7);

    expect(result, bytes);
    expect(log.single.method, 'GET');
    expect(log.single.path, 'api/certificates/7/download');
    expect(log.single.responseType, ResponseType.bytes);
  });

  test('notifications read-all POST calls api/notifications/read-all', () async {
    final log = <RequestOptions>[];

    await _apiResolving(<String, dynamic>{}, log).markAllNotificationsRead();

    expect(log.single.method, 'POST');
    expect(log.single.path, 'api/notifications/read-all');
  });

  test('preferences PATCH calls api/users/me/preferences', () async {
    final log = <RequestOptions>[];

    final prefs = await _apiResolving(_prefsJson, log).updatePreferences(
      const UpdatePreferencesRequest(language: 'ar', theme: 'dark'),
    );

    expect(prefs.language, 'ar');
    expect(log.single.method, 'PATCH');
    expect(log.single.path, 'api/users/me/preferences');
    expect(log.single.data, containsPair('language', 'ar'));
    expect(log.single.data, containsPair('theme', 'dark'));
  });

  test('support POST calls api/support/contact', () async {
    final log = <RequestOptions>[];

    await _apiResolving(
      <String, dynamic>{},
      log,
    ).sendSupportMessage(
      const SupportContactRequest(
        message: 'Help',
        subject: 'Billing',
        category: 'payment',
      ),
    );

    expect(log.single.method, 'POST');
    expect(log.single.path, 'api/support/contact');
    expect(log.single.data, {
      'message': 'Help',
      'subject': 'Billing',
      'category': 'payment',
    });
  });
}
