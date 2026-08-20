import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/auth/data/models/forgot_password_request.dart';
import 'package:coach_space/features/auth/data/models/login_request.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/resend_verification_request.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

/// Orchestrates all authentication flows against [AuthRepository].
///
/// The repository persists the session; this cubit only translates outcomes
/// into states the UI can render/navigate on. Transport errors are surfaced as
/// [NetworkException] messages (already localized at the boundary).
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepository repository}) : super(const AuthInitial()) {
    _repository = repository;
  }

  late final AuthRepository _repository;

  /// Re-hydrates a persisted session on app startup (splash phase).
  Future<void> restoreSession() async {
    emit(const AuthRestoringSession());
    final session = await _repository.restoreSession();
    if (session == null) {
      emit(const AuthUnauthenticated());
      return;
    }
    if (session.isPendingInstructor) {
      emit(AuthPendingApproval(session));
    } else {
      emit(AuthAuthenticated(session));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthLoginLoading());
    try {
      final session = await _repository.login(
        LoginRequest(email: email, password: password),
      );
      if (session.isPendingInstructor) {
        emit(AuthPendingApproval(session));
      } else {
        emit(AuthAuthenticated(session));
      }
    } catch (error) {
      emit(AuthLoginFailure(_messageOf(error)));
    }
  }

  Future<void> register(RegisterRequest request) async {
    emit(const AuthRegisterLoading());
    try {
      final response = await _repository.register(request);
      emit(AuthRegisterSuccess(response));
    } catch (error) {
      emit(AuthRegisterFailure(_messageOf(error)));
    }
  }

  /// Server-side revocation is best-effort; local session is always cleared
  /// and the flow ends in [AuthUnauthenticated].
  Future<void> logout() async {
    emit(const AuthLogoutLoading());
    await _repository.logout();
    emit(const AuthUnauthenticated());
  }

  Future<void> forgotPassword(String email) async {
    emit(const AuthPasswordLoading());
    try {
      await _repository.forgotPassword(ForgotPasswordRequest(email: email));
      emit(const AuthPasswordSuccess());
    } catch (error) {
      emit(AuthPasswordFailure(_messageOf(error)));
    }
  }

  Future<void> resendVerification(String email) async {
    emit(const AuthResendLoading());
    try {
      await _repository.resendEmailVerification(
        ResendVerificationRequest(email: email),
      );
      emit(const AuthResendSuccess());
    } catch (error) {
      emit(AuthResendFailure(_messageOf(error)));
    }
  }

  String _messageOf(Object error) {
    if (error is NetworkException) return error.message;
    return 'حدث خطأ، حاول مرة أخرى';
  }
}
