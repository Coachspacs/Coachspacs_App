import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/data/models/checkout_session_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/order_repository.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
  })  : _cartRepository = cartRepository,
        _orderRepository = orderRepository,
        super(const CheckoutInitial());

  final CartRepository _cartRepository;
  final OrderRepository _orderRepository;

  Future<void> load() async {
    emit(const CheckoutLoading());
    try {
      final cart = await _cartRepository.getCart();
      if (cart.isEmpty) {
        emit(const CheckoutEmpty());
      } else {
        emit(CheckoutReady(cart));
      }
    } on NetworkException catch (error) {
      emit(CheckoutFailure(error.kind, error.message));
    } catch (_) {
      emit(const CheckoutFailure(FailureKind.unknown, _fallbackMessage));
    }
  }

  /// Starts a Stripe Checkout session for the current cart
  /// (`POST /api/orders/checkout`). The server creates a pending order and
  /// returns the hosted `checkout_url` the student is redirected to (US-15).
  Future<void> placeOrder({String? couponCode}) async {
    if (state is! CheckoutReady) return;
    emit(const CheckoutPlacing());
    try {
      final session = await _orderRepository.checkout(couponCode: couponCode);
      emit(CheckoutSuccess(session));
    } on NetworkException catch (error) {
      emit(CheckoutFailure(error.kind, error.message));
    } catch (_) {
      emit(const CheckoutFailure(FailureKind.unknown, _fallbackMessage));
    }
  }
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';