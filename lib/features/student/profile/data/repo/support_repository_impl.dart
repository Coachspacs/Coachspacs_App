import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/models/support_contact_request.dart';

import 'support_repository.dart';

class SupportRepositoryImpl implements SupportRepository {
  SupportRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<void> sendContactMessage({
    required String message,
    String subject = '',
    String category = '',
  }) => _guard(
    () => _api.sendSupportMessage(
      SupportContactRequest(
        message: message,
        subject: subject,
        category: category,
      ),
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
