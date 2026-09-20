part of 'checkout_cubit.dart';

sealed class CheckoutState {
  const CheckoutState();
}

final class CheckoutInitial extends CheckoutState {
  const CheckoutInitial();
}

final class CheckoutLoading extends CheckoutState {
  const CheckoutLoading();
}

final class CheckoutEmpty extends CheckoutState {
  const CheckoutEmpty();
}

final class CheckoutReady extends CheckoutState {
  const CheckoutReady(this.cart);

  final CartDto cart;
}

final class CheckoutPlacing extends CheckoutState {
  const CheckoutPlacing();
}

final class CheckoutSuccess extends CheckoutState {
  const CheckoutSuccess(this.session);

  final CheckoutSessionDto session;
}

final class CheckoutFailure extends CheckoutState {
  const CheckoutFailure(this.kind, this.message);

  final FailureKind kind;
  final String message;
}