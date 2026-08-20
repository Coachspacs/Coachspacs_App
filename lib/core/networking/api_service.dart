import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:coach_space/features/auth/data/models/change_password_request.dart';
import 'package:coach_space/features/auth/data/models/forgot_password_request.dart';
import 'package:coach_space/features/auth/data/models/login_request.dart';
import 'package:coach_space/features/auth/data/models/login_response.dart';
import 'package:coach_space/features/auth/data/models/logout_request.dart';
import 'package:coach_space/features/auth/data/models/refresh_token_request.dart';
import 'package:coach_space/features/auth/data/models/refresh_token_response.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/register_response.dart';
import 'package:coach_space/features/auth/data/models/resend_verification_request.dart';
import 'package:coach_space/features/auth/data/models/reset_password_request.dart';

part 'api_service.g.dart';

/// Typed client for the Coach Space auth API.
///
/// Paths intentionally start with `api/...` (no leading slash) so they are
/// appended to the Dio `baseUrl` and never rewrite the `/api/v1/` style prefix.
/// Auth endpoints live under `/api/auth/` per the live Swagger contract.
@RestApi(baseUrl: '')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('api/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest body);

  @POST('api/auth/register')
  Future<RegisterResponse> register(@Body() RegisterRequest body);

  @POST('api/auth/refresh')
  Future<RefreshTokenResponse> refresh(@Body() RefreshTokenRequest body);

  /// Idempotent; returns 200 even for already-blacklisted tokens.
  @POST('api/auth/logout')
  Future<void> logout(@Body() LogoutRequest body);

  @POST('api/auth/password/forgot')
  Future<void> forgotPassword(@Body() ForgotPasswordRequest body);

  @POST('api/auth/password/reset')
  Future<void> resetPassword(@Body() ResetPasswordRequest body);

  @PUT('api/auth/password/change')
  Future<void> changePassword(@Body() ChangePasswordRequest body);

  @GET('api/auth/verify-email')
  Future<void> verifyEmail(
    @Query('uid') String uid,
    @Query('token') String token,
  );

  @POST('api/auth/verify-email/resend')
  Future<void> resendVerification(@Body() ResendVerificationRequest body);
}
