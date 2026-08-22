import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/storage/session_storage.dart';
import 'package:coach_space/features/auth/data/models/change_password_request.dart';
import 'package:coach_space/features/auth/data/models/forgot_password_request.dart';
import 'package:coach_space/features/auth/data/models/login_request.dart';
import 'package:coach_space/features/auth/data/models/logout_request.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/register_response.dart';
import 'package:coach_space/features/auth/data/models/resend_verification_request.dart';
import 'package:coach_space/features/auth/data/models/reset_password_request.dart';
import 'package:coach_space/features/auth/data/models/user_session.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository.dart';

/// Retrofit-backed [AuthRepository].
///
/// Every transport error is normalized to a typed [NetworkException] so callers
/// (the `AuthCubit`) never see raw `DioException`s.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required ApiService apiService,
    required SessionStorage sessionStorage,
  }) : _api = apiService,
       _storage = sessionStorage;

  final ApiService _api;
  final SessionStorage _storage;

  @override
  Future<UserSession> login(LoginRequest request) async {
    final response = await _guard(() => _api.login(request));
    final session = UserSession(
      access: response.access,
      refresh: response.refresh,
      role: response.role,
      approvalStatus: response.approvalStatus,
    );
    await _storage.saveSession(session);
    return session;
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) =>
      _guard(() => _api.register(request));

  @override
  Future<void> logout() async {
    final refresh = await _storage.readRefreshToken();
    try {
      if (refresh != null && refresh.isNotEmpty) {
        await _api.logout(LogoutRequest(refresh: refresh));
      }
    } on DioException {
      // Idempotent per the schema; a failed revocation must not block logout.
    } on NetworkException {
      // Same: swallowed on purpose.
    } finally {
      await _storage.clear();
    }
  }

  @override
  Future<void> forgotPassword(ForgotPasswordRequest request) =>
      _guard(() => _api.forgotPassword(request));

  @override
  Future<void> resetPassword(ResetPasswordRequest request) =>
      _guard(() => _api.resetPassword(request));

  @override
  Future<void> changePassword(ChangePasswordRequest request) =>
      _guard(() => _api.changePassword(request));

  @override
  Future<void> verifyEmail({required String uid, required String token}) =>
      _guard(() => _api.verifyEmail(uid, token));

  @override
  Future<void> resendEmailVerification(ResendVerificationRequest request) =>
      _guard(() => _api.resendVerification(request));

  @override
  Future<UserSession?> restoreSession() => _storage.readSession();

  @override
  Future<void> clearSession() => _storage.clear();

  @override
  Future<void> fetchInstructorDashboard() =>
      _guard(() => _api.instructorDashboard());

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
