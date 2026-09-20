import 'package:dio/dio.dart';

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
  Future<OrderDto> createOrder({String? couponCode}) => _guard(
        () => _api.createOrder(CreateOrderRequest(couponCode: couponCode)),
      );

  @override
  Future<CheckoutSessionDto> checkout({String? couponCode}) => _guard(
        () => _api.checkout(CheckoutRequest(couponCode: couponCode)),
      );

  @override
  Future<PaginatedResponse<OrderDto>> getOrders({
    int page = 1,
    int pageSize = 10,
  }) =>
      _guard(
        () => _api.getOrders(page: page, pageSize: pageSize),
      );

  @override
  Future<OrderDto> getOrder(int id) => _guard(() => _api.getOrder(id));

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
