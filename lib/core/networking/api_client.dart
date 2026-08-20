import 'package:dio/dio.dart';

import 'package:coach_space/core/storage/session_storage.dart';

import 'api_interceptor.dart';
import 'safe_logging_interceptor.dart';

/// Central HTTP client factory for the Coach Space API.
///
/// Base URL is the single environment config point; override for staging/prod
/// with `--dart-define=API_BASE_URL=https://...`.
class ApiClient {
  ApiClient._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://coachspace-back.onrender.com/',
  );

  static Dio create({SessionStorage? sessionStorage}) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
        headers: const {'Accept': 'application/json'},
      ),
    );
    if (sessionStorage != null) {
      dio.interceptors.add(AuthInterceptor(sessionStorage, () => dio));
    }
    dio.interceptors.add(SafeLoggingInterceptor());
    return dio;
  }
}
