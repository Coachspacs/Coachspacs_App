import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_client.dart';
import 'package:coach_space/features/auth/data/models/auth_login_response.dart';

class AuthRepository {
  AuthRepository({Dio? dio}) : _dio = dio ?? ApiClient.create();

  final Dio _dio;

  Future<AuthLoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );
    final data = response.data ?? <String, dynamic>{};
    return AuthLoginResponse.fromJson(data);
  }

  Future<void> resendEmailVerification({required String email}) async {
    await _dio.post<void>(
      '/api/auth/verify-email/resend',
      data: {'email': email},
    );
  }

  Future<void> verifyEmail({
    required String uid,
    required String token,
  }) async {
    await _dio.get<void>(
      '/api/auth/verify-email',
      queryParameters: {'uid': uid, 'token': token},
    );
  }

  Future<AuthLoginResponse> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/api/auth/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    final data = response.data ?? <String, dynamic>{};
    return AuthLoginResponse.fromJson(data);
  }

  Future<void> verifyOtp({
    required String email,
    required String code,
  }) async {
    await _dio.post<void>(
      '/api/auth/verify-otp',
      data: {'email': email, 'code': code},
    );
  }
}
