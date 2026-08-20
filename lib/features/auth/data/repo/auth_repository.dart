import 'package:coach_space/features/auth/data/models/change_password_request.dart';
import 'package:coach_space/features/auth/data/models/forgot_password_request.dart';
import 'package:coach_space/features/auth/data/models/login_request.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/register_response.dart';
import 'package:coach_space/features/auth/data/models/resend_verification_request.dart';
import 'package:coach_space/features/auth/data/models/reset_password_request.dart';
import 'package:coach_space/features/auth/data/models/user_session.dart';

/// Contract for the auth data layer (backend contract in COACH_SPACE_ARCHITECTURE).
///
/// Implementations translate typed [NetworkException]s into [UserSession]s and
/// persist the session via [SessionStorage]. UI code depends on this interface,
/// never on a concrete HTTP client.
abstract interface class AuthRepository {
  /// Exchanges credentials for a session. Persists tokens + identity on success.
  Future<UserSession> login(LoginRequest request);

  /// Creates an account. Does **not** authenticate: the account is unverified
  /// and must confirm its email link before the first login.
  Future<RegisterResponse> register(RegisterRequest request);

  /// Best-effort server-side logout (blacklists the refresh token). Local
  /// session is always cleared; this method never throws.
  Future<void> logout();

  Future<void> forgotPassword(ForgotPasswordRequest request);

  Future<void> resetPassword(ResetPasswordRequest request);

  /// Requires a valid authenticated session (uses the stored access token).
  Future<void> changePassword(ChangePasswordRequest request);

  /// Called by the emailed verification link.
  Future<void> verifyEmail({required String uid, required String token});

  Future<void> resendEmailVerification(ResendVerificationRequest request);

  /// Re-hydrates the persisted session, or `null` when logged out/corrupted.
  Future<UserSession?> restoreSession();

  /// Wipes the persisted session without any network call.
  Future<void> clearSession();
}
