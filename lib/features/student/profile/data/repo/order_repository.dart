import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/checkout_session_dto.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';

/// Contract for `GET/POST /api/orders` and `POST /api/orders/checkout`.
abstract class OrderRepository {
  Future<OrderDto> createOrder({String? couponCode});

  /// Starts a Stripe Checkout Session for the current cart (US-15) and
  /// returns the hosted URL to redirect the student to.
  Future<CheckoutSessionDto> checkout({String? couponCode});

  Future<PaginatedResponse<OrderDto>> getOrders({
    int page = 1,
    int pageSize = 10,
  });

  Future<OrderDto> getOrder(int id);
}
