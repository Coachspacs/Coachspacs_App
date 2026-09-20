import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._repository) : super(const CartInitial());

  final CartRepository _repository;

  Future<void> load() async {
    emit(const CartLoading());
    try {
      final cart = await _repository.getCart();
      emit(CartSuccess(cart));
    } on NetworkException catch (error) {
      emit(CartFailure(error.kind, error.message));
    } catch (_) {
      emit(const CartFailure(FailureKind.unknown, _fallbackMessage));
    }
  }

  /// Removes [itemId] and reloads the cart. Returns `true` on success.
  ///
  /// On failure the current cart is preserved so the user can retry without
  /// losing the screen; callers surface the localized error themselves.
  Future<bool> removeItem(int itemId) async {
    try {
      await _repository.removeItem(itemId);
    } catch (_) {
      return false;
    }
    await load();
    return true;
  }
}

const String _fallbackMessage = 'حدث خطأ، حاول مرة أخرى';
