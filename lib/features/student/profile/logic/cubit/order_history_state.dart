part of 'order_history_cubit.dart';

sealed class OrderHistoryState {
  const OrderHistoryState();
}

final class OrderHistoryInitial extends OrderHistoryState {
  const OrderHistoryInitial();
}

final class OrderHistoryLoading extends OrderHistoryState {
  const OrderHistoryLoading();
}

final class OrderHistorySuccess extends OrderHistoryState {
  const OrderHistorySuccess(this.orders, this.hasMore);

  final List<OrderDto> orders;
  final bool hasMore;
}

final class OrderHistoryEmpty extends OrderHistoryState {
  const OrderHistoryEmpty();
}

final class OrderHistoryFailure extends OrderHistoryState {
  const OrderHistoryFailure(this.kind, this.message);

  final FailureKind kind;
  final String message;
}
