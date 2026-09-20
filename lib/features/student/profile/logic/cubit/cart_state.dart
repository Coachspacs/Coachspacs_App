part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {
  const CartInitial();
}

final class CartLoading extends CartState {
  const CartLoading();
}

final class CartSuccess extends CartState {
  const CartSuccess(this.cart);

  final CartDto cart;
}

final class CartFailure extends CartState {
  const CartFailure(this.kind, this.message);

  final FailureKind kind;
  final String message;
}
