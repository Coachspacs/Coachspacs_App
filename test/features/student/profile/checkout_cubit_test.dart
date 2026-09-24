import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/data/models/checkout_session_dto.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/order_repository.dart';
import 'package:coach_space/features/student/profile/logic/cubit/checkout_cubit.dart';

final _cartItem = CartItemDto(
  id: 3,
  course: CartItemCourseDto(
    id: 5,
    title: 'Flutter Basics',
    price: '29.99',
    coverImage: '',
    status: 'published',
  ),
  isAvailable: true,
  addedAt: DateTime(2026, 1, 1),
);

CartDto _cart({bool empty = false}) => CartDto(
  id: 1,
  items: empty ? [] : [_cartItem],
  itemCount: empty ? 0 : 1,
  total: empty ? '0.00' : '29.99',
  createdAt: DateTime(2026, 1, 1),
);

CheckoutSessionDto _session({String url = 'https://checkout.stripe.com/xyz'}) =>
    CheckoutSessionDto(orderId: 42, checkoutUrl: url);

class _FakeCartRepository implements CartRepository {
  CartDto? cart;
  Object? error;

  @override
  Future<CartDto> getCart() async {
    if (error != null) throw error!;
    return cart!;
  }

  @override
  Future<void> addItem(int courseId) async {}

  @override
  Future<void> removeItem(int itemId) async {}
}

class _FakeOrderRepository implements OrderRepository {
  CheckoutSessionDto? session;
  Object? error;

  @override
  Future<CheckoutSessionDto> checkout() async {
    if (error != null) throw error!;
    return session!;
  }

  @override
  Future<PaginatedResponse<OrderDto>> getOrders({
    int page = 1,
    int pageSize = 10,
  }) async => throw UnimplementedError();
}

void main() {
  late _FakeCartRepository cartRepository;
  late _FakeOrderRepository orderRepository;
  late CheckoutCubit cubit;

  setUp(() {
    cartRepository = _FakeCartRepository();
    orderRepository = _FakeOrderRepository();
    cubit = CheckoutCubit(
      cartRepository: cartRepository,
      orderRepository: orderRepository,
    );
  });

  tearDown(() => cubit.close());

  group('CheckoutCubit.load', () {
    test('emits Loading then Ready for a non-empty cart', () async {
      cartRepository.cart = _cart();
      final emissions = <CheckoutState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<CheckoutLoading>(), isA<CheckoutReady>()]);
      expect((cubit.state as CheckoutReady).cart.itemCount, 1);

      await subscription.cancel();
    });

    test('emits CheckoutEmpty for an empty cart', () async {
      cartRepository.cart = _cart(empty: true);

      await cubit.load();

      expect(cubit.state, isA<CheckoutEmpty>());
    });

    test('emits CheckoutFailure with kind and message on error', () async {
      cartRepository.error = const NetworkException(
        kind: FailureKind.unauthorized,
        message: 'Login again',
      );

      await cubit.load();

      expect(cubit.state, isA<CheckoutFailure>());
      final failure = cubit.state as CheckoutFailure;
      expect(failure.kind, FailureKind.unauthorized);
      expect(failure.message, 'Login again');
    });
  });

  group('CheckoutCubit.placeOrder', () {
    test('emits CheckoutSuccess with the hosted checkout session', () async {
      cartRepository.cart = _cart();
      orderRepository.session = _session();
      await cubit.load();
      final emissions = <CheckoutState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.placeOrder();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<CheckoutPlacing>(), isA<CheckoutSuccess>()]);
      final success = cubit.state as CheckoutSuccess;
      expect(success.session.orderId, 42);
      expect(success.session.hasCheckoutUrl, isTrue);

      await subscription.cancel();
    });

    test('emits CheckoutFailure when starting checkout fails', () async {
      cartRepository.cart = _cart();
      orderRepository.error = const NetworkException(
        kind: FailureKind.validation,
        message: 'Checkout failed',
      );
      await cubit.load();

      await cubit.placeOrder();

      expect(cubit.state, isA<CheckoutFailure>());
      final failure = cubit.state as CheckoutFailure;
      expect(failure.kind, FailureKind.validation);
      expect(failure.message, 'Checkout failed');
    });

    test('does nothing when the checkout is not ready', () async {
      await cubit.placeOrder();

      expect(cubit.state, isA<CheckoutInitial>());
    });
  });
}
