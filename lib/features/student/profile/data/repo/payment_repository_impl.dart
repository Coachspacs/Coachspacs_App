import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/payment_intent_dto.dart';

import 'payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<PaymentIntentDto> createIntent({
    required int orderId,
    String? provider,
  }) =>
      _guard(
        () => _api.createPaymentIntent(
          CreatePaymentIntentRequest(orderId: orderId, provider: provider),
        ),
      );

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
