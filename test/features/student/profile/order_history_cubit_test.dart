import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/checkout_session_dto.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/order_repository.dart';
import 'package:coach_space/features/student/profile/logic/cubit/order_history_cubit.dart';

typedef _OrdersCall = ({int page, int pageSize});

OrderDto _order(int id) => OrderDto(
  id: id,
  orderNumber: 'ORD-$id',
  status: OrderStatus.paid,
  items: const [
    OrderItemDto(
      id: 1,
      courseId: 5,
      courseTitle: 'Flutter Basics',
      coverImage: '',
      price: '29.99',
    ),
  ],
  subtotal: '29.99',
  discount: '0.00',
  tax: '0.00',
  total: '29.99',
  currency: 'USD',
  createdAt: DateTime(2026, 1, 3),
);

class _FakeOrderRepository implements OrderRepository {
  final List<PaginatedResponse<OrderDto>> pages = [];
  final List<_OrdersCall> requests = [];
  Object? error;

  @override
  Future<PaginatedResponse<OrderDto>> getOrders({
    int page = 1,
    int pageSize = 10,
  }) async {
    requests.add((page: page, pageSize: pageSize));
    if (error != null) throw error!;
    return pages[page - 1];
  }

  @override
  Future<OrderDto> createOrder({String? couponCode}) async =>
      throw UnimplementedError();

  @override
  Future<OrderDto> getOrder(int id) async => throw UnimplementedError();

  @override
  Future<CheckoutSessionDto> checkout({String? couponCode}) async =>
      throw UnimplementedError();
}

void main() {
  late _FakeOrderRepository repository;
  late OrderHistoryCubit cubit;

  setUp(() {
    repository = _FakeOrderRepository();
    cubit = OrderHistoryCubit(repository);
  });

  tearDown(() => cubit.close());

  group('OrderHistoryCubit.load', () {
    test('emits Loading then Success with hasMore from the page', () async {
      repository.pages.add(
        PaginatedResponse(
          count: 25,
          next: 'http://test.local/api/orders?page=2',
          results: [for (var id = 1; id <= 10; id++) _order(id)],
        ),
      );
      final emissions = <OrderHistoryState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<OrderHistoryLoading>(), isA<OrderHistorySuccess>()]);
      final state = cubit.state as OrderHistorySuccess;
      expect(state.orders, hasLength(10));
      expect(state.hasMore, isTrue);
      expect(repository.requests.single.pageSize, 10);

      await subscription.cancel();
    });

    test('derives hasMore when the page is full but next is absent', () async {
      repository.pages.add(
        PaginatedResponse(
          count: 25,
          results: [for (var id = 1; id <= 10; id++) _order(id)],
        ),
      );

      await cubit.load();

      expect((cubit.state as OrderHistorySuccess).hasMore, isTrue);
    });

    test('emits OrderHistoryEmpty when there are no orders', () async {
      repository.pages.add(const PaginatedResponse(count: 0, results: []));

      await cubit.load();

      expect(cubit.state, isA<OrderHistoryEmpty>());
    });

    test('emits OrderHistoryFailure with kind and message', () async {
      repository.error = const NetworkException(
        kind: FailureKind.serverError,
        message: 'Orders unavailable',
      );

      await cubit.load();

      expect(cubit.state, isA<OrderHistoryFailure>());
      final failure = cubit.state as OrderHistoryFailure;
      expect(failure.kind, FailureKind.serverError);
      expect(failure.message, 'Orders unavailable');
    });
  });

  group('OrderHistoryCubit.loadMore', () {
    test('appends the next page and clears hasMore at the end', () async {
      repository.pages.addAll([
        PaginatedResponse(
          count: 15,
          next: 'http://test.local/api/orders?page=2',
          results: [for (var id = 1; id <= 10; id++) _order(id)],
        ),
        PaginatedResponse(
          count: 15,
          results: [for (var id = 11; id <= 15; id++) _order(id)],
        ),
      ]);
      await cubit.load();

      await cubit.loadMore();

      final state = cubit.state as OrderHistorySuccess;
      expect(state.orders.map((order) => order.id), [
        for (var id = 1; id <= 15; id++) id,
      ]);
      expect(state.hasMore, isFalse);
      expect(repository.requests.map((call) => call.page), [1, 2]);
    });

    test('does nothing when there is no next page', () async {
      repository.pages.add(
        PaginatedResponse(count: 3, results: [for (var id = 1; id <= 3; id++) _order(id)]),
      );
      await cubit.load();

      await cubit.loadMore();

      expect(repository.requests, hasLength(1));
    });
  });
}
