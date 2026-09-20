import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';

/// Contract for `GET/POST/DELETE /api/cart` endpoints.
abstract class CartRepository {
  Future<CartDto> getCart();

  Future<CartItemDto> addItem(int courseId);

  Future<void> removeItem(int itemId);
}
