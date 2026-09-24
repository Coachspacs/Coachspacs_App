import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/checkout_session_dto.dart';
import 'package:coach_space/features/student/profile/data/models/order_dto.dart';

import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<CheckoutSessionDto> checkout() => _guard(() => _api.checkout());

  @override
  Future<PaginatedResponse<OrderDto>> getOrders({
    int page = 1,
    int pageSize = 10,
  }) =>
      _guard(
        () => _api.getOrders(page: page, pageSize: pageSize),
      );

  Future<T> _guard<T>(Future<T> Function() request) =>
      NetworkException.guard(request);
}
