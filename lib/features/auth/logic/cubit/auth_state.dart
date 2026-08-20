import 'package:equatable/equatable.dart';

import 'package:coach_space/features/auth/data/models/register_response.dart';
import 'package:coach_space/features/auth/data/models/user_session.dart';

/// Auth status flow:
///
/// ```
/// AuthInitial
///   └─ restoreSession() → AuthRestoringSession → AuthAuthenticated | AuthPendingApproval | AuthUnauthenticated
/// AuthUnauthenticated ── login() ──▶ AuthLoginLoading ──▶ AuthAuthenticated | AuthPendingApproval | AuthLoginFailure
/// ```
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => const [];
}

/// No auth work has happened yet (app boot).
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Re-hydrating the persisted session from secure storage.
class AuthRestoringSession extends AuthState {
  const AuthRestoringSession();
}

/// A valid session is active and the user has full access.
class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.session);

  final UserSession session;

  @override
  List<Object?> get props => [session];
}

/// An instructor session awaiting admin approval — limited access only.
class AuthPendingApproval extends AuthState {
  const AuthPendingApproval(this.session);

  final UserSession session;

  @override
  List<Object?> get props => [session];
}

/// No session (logged out or never logged in).
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthLoginLoading extends AuthState {
  const AuthLoginLoading();
}

class AuthLoginFailure extends AuthState {
  const AuthLoginFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class AuthRegisterLoading extends AuthState {
  const AuthRegisterLoading();
}

/// Registration succeeded — the account is unverified and must confirm its
/// email link before the first login.
class AuthRegisterSuccess extends AuthState {
  const AuthRegisterSuccess(this.response);

  final RegisterResponse response;

  @override
  List<Object?> get props => [response];
}

class AuthRegisterFailure extends AuthState {
  const AuthRegisterFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class AuthLogoutLoading extends AuthState {
  const AuthLogoutLoading();
}

class AuthPasswordLoading extends AuthState {
  const AuthPasswordLoading();
}

/// Forgot-password request accepted by the backend.
class AuthPasswordSuccess extends AuthState {
  const AuthPasswordSuccess();
}

class AuthPasswordFailure extends AuthState {
  const AuthPasswordFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class AuthResendLoading extends AuthState {
  const AuthResendLoading();
}

class AuthResendSuccess extends AuthState {
  const AuthResendSuccess();
}

class AuthResendFailure extends AuthState {
  const AuthResendFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
