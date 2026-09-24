import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';

import 'cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<CartDto> getCart() => _guard(() => _api.getCart());

  @override
  Future<void> addItem(int courseId) => _guard(
        () => _api.addCartItem(AddCartItemRequest(courseId: courseId)),
      );

  @override
  Future<void> removeItem(int itemId) =>
      _guard(() => _api.removeCartItem(itemId));

  Future<T> _guard<T>(Future<T> Function() request) =>
      NetworkException.guard(request);
}
