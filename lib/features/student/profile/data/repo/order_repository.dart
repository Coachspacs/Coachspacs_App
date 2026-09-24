import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/checkout_session_dto.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';

/// Contract for `GET /api/orders` and `POST /api/orders/checkout`.
abstract class OrderRepository {
  /// Starts a Stripe Checkout Session for the current cart (US-15) and
  /// returns the hosted URL to redirect the student to.
  Future<CheckoutSessionDto> checkout();

  Future<PaginatedResponse<OrderDto>> getOrders({
    int page = 1,
    int pageSize = 10,
  });
}
