import 'package:dio/dio.dart';

class ApiClient {
  ApiClient._();

  static const String baseUrl = 'https://coachspace-back.onrender.com';

  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: const {'Accept': 'application/json'},
      ),
    );
  }
}
