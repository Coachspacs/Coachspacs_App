import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository.dart';
import 'package:coach_space/features/student/profile/logic/cubit/cart_cubit.dart';

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

class _FakeCartRepository implements CartRepository {
  CartDto? cart;
  Object? getCartError;
  Object? removeError;
  int getCartCalls = 0;
  final List<int> removedItemIds = [];

  @override
  Future<CartDto> getCart() async {
    getCartCalls++;
    if (getCartError != null) throw getCartError!;
    return cart!;
  }

  @override
  Future<void> addItem(int courseId) async {}

  @override
  Future<void> removeItem(int itemId) async {
    removedItemIds.add(itemId);
    if (removeError != null) throw removeError!;
  }
}

void main() {
  late _FakeCartRepository repository;
  late CartCubit cubit;

  setUp(() {
    repository = _FakeCartRepository();
    cubit = CartCubit(repository);
  });

  tearDown(() => cubit.close());

  group('CartCubit.load', () {
    test('emits Loading then Success with the cart', () async {
      repository.cart = _cart();
      final emissions = <CartState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<CartLoading>(), isA<CartSuccess>()]);
      expect((cubit.state as CartSuccess).cart.items, hasLength(1));

      await subscription.cancel();
    });

    test('emits CartFailure with kind and message on NetworkException', () async {
      repository.getCartError = const NetworkException(
        kind: FailureKind.offline,
        message: 'No connection',
      );

      await cubit.load();

      expect(cubit.state, isA<CartFailure>());
      final failure = cubit.state as CartFailure;
      expect(failure.kind, FailureKind.offline);
      expect(failure.message, 'No connection');
    });
  });

  group('CartCubit.removeItem', () {
    test('removes the item, reloads the cart and returns true', () async {
      repository.cart = _cart();
      await cubit.load();

      final result = await cubit.removeItem(3);

      expect(result, isTrue);
      expect(repository.removedItemIds, [3]);
      expect(repository.getCartCalls, 2);
      expect(cubit.state, isA<CartSuccess>());
    });

    test('returns false and keeps the current cart on failure', () async {
      repository.cart = _cart();
      repository.removeError = const NetworkException(
        kind: FailureKind.serverError,
        message: 'boom',
      );
      await cubit.load();
      final stateBefore = cubit.state;

      final result = await cubit.removeItem(3);

      expect(result, isFalse);
      expect(repository.removedItemIds, [3]);
      expect(repository.getCartCalls, 1);
      expect(cubit.state, same(stateBefore));
    });
  });
}
