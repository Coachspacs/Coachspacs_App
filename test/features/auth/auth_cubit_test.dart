import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/auth/data/models/approval_status.dart';
import 'package:coach_space/features/auth/data/models/change_password_request.dart';
import 'package:coach_space/features/auth/data/models/forgot_password_request.dart';
import 'package:coach_space/features/auth/data/models/login_request.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/register_response.dart';
import 'package:coach_space/features/auth/data/models/resend_verification_request.dart';
import 'package:coach_space/features/auth/data/models/reset_password_request.dart';
import 'package:coach_space/features/auth/data/models/user_role.dart';
import 'package:coach_space/features/auth/data/models/user_session.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_state.dart';

class _FakeAuthRepository implements AuthRepository {
  UserSession? loginResult;
  Object? loginError;
  RegisterResponse? registerResult;
  Object? registerError;
  Object? forgotError;
  Object? resendError;
  UserSession? storedSession;

  @override
  Future<UserSession> login(LoginRequest request) async {
    if (loginError != null) throw loginError!;
    return loginResult!;
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    if (registerError != null) throw registerError!;
    return registerResult!;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    if (forgotError != null) throw forgotError!;
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {}

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {}

  @override
  Future<void> verifyEmail({
    required String uid,
    required String token,
  }) async {}

  @override
  Future<void> resendEmailVerification(
    ResendVerificationRequest request,
  ) async {
    if (resendError != null) throw resendError!;
  }

  @override
  Future<UserSession?> restoreSession() async => storedSession;

  @override
  Future<void> clearSession() async {}

  @override
  Future<void> fetchInstructorDashboard() async {}
}

UserSession session({
  UserRole role = UserRole.student,
  ApprovalStatus approvalStatus = ApprovalStatus.approved,
}) {
  return UserSession(
    access: 'access-1',
    refresh: 'refresh-1',
    role: role,
    approvalStatus: approvalStatus,
  );
}

void main() {
  late _FakeAuthRepository repo;
  late AuthCubit cubit;

  setUp(() {
    repo = _FakeAuthRepository();
    cubit = AuthCubit(repository: repo);
  });

  tearDown(() => cubit.close());

  group('restoreSession', () {
    test('restores a valid session as AuthAuthenticated', () async {
      repo.storedSession = session();

      await cubit.restoreSession();

      expect(cubit.state, isA<AuthAuthenticated>());
      expect((cubit.state as AuthAuthenticated).session.role, UserRole.student);
    });

    test('routes pending instructors to AuthPendingApproval', () async {
      repo.storedSession = session(
        role: UserRole.instructor,
        approvalStatus: ApprovalStatus.pending,
      );

      await cubit.restoreSession();

      expect(cubit.state, isA<AuthPendingApproval>());
    });

    test('emits AuthUnauthenticated when nothing is stored', () async {
      await cubit.restoreSession();

      expect(cubit.state, const AuthUnauthenticated());
    });
  });

  group('login', () {
    test('emits AuthAuthenticated for an approved student', () async {
      repo.loginResult = session();

      await cubit.login(email: 'a@b.com', password: 'secret');

      expect(cubit.state, isA<AuthAuthenticated>());
      final auth = cubit.state as AuthAuthenticated;
      expect(auth.session.role, UserRole.student);
    });

    test('emits AuthPendingApproval for a pending instructor', () async {
      repo.loginResult = session(
        role: UserRole.instructor,
        approvalStatus: ApprovalStatus.pending,
      );

      await cubit.login(email: 't@c.com', password: 'secret');

      expect(cubit.state, isA<AuthPendingApproval>());
    });

    test('emits AuthLoginFailure with the backend message on error', () async {
      repo.loginError = const NetworkException(
        kind: FailureKind.unauthorized,
        message: 'No active account found with the given credentials.',
      );

      await cubit.login(email: 'a@b.com', password: 'nope');

      expect(cubit.state, isA<AuthLoginFailure>());
      expect(
        (cubit.state as AuthLoginFailure).message,
        'No active account found with the given credentials.',
      );
    });
  });

  group('register', () {
    test('emits AuthRegisterSuccess with the created account', () async {
      repo.registerResult = const RegisterResponse(
        id: 7,
        email: 'jane@example.com',
        role: UserRole.student,
        detail: 'Check your inbox.',
      );

      await cubit.register(
        const RegisterRequest(
          fullName: 'Jane Doe',
          email: 'jane@example.com',
          password: 'secret',
          role: UserRole.student,
        ),
      );

      expect(cubit.state, isA<AuthRegisterSuccess>());
      expect((cubit.state as AuthRegisterSuccess).response.id, 7);
    });

    test('emits AuthRegisterFailure on error', () async {
      repo.registerError = const NetworkException(
        kind: FailureKind.validation,
        message: 'A user with that email already exists.',
      );

      await cubit.register(
        const RegisterRequest(
          fullName: 'Jane Doe',
          email: 'jane@example.com',
          password: 'secret',
          role: UserRole.student,
        ),
      );

      expect(cubit.state, isA<AuthRegisterFailure>());
    });
  });

  group('forgotPassword', () {
    test('emits AuthPasswordSuccess on success', () async {
      await cubit.forgotPassword('a@b.com');

      expect(cubit.state, const AuthPasswordSuccess());
    });

    test('emits AuthPasswordFailure on error', () async {
      repo.forgotError = const NetworkException(
        kind: FailureKind.offline,
        message: 'تعذر الاتصال بالخادم، تحقق من اتصالك بالإنترنت',
      );

      await cubit.forgotPassword('a@b.com');

      expect(cubit.state, isA<AuthPasswordFailure>());
      expect(
        (cubit.state as AuthPasswordFailure).message,
        'تعذر الاتصال بالخادم، تحقق من اتصالك بالإنترنت',
      );
    });
  });

  group('resendVerification', () {
    test('emits AuthResendSuccess on success', () async {
      await cubit.resendVerification('a@b.com');

      expect(cubit.state, const AuthResendSuccess());
    });

    test('emits AuthResendFailure on error', () async {
      repo.resendError = const NetworkException(
        kind: FailureKind.serverError,
        message: 'Server error',
      );

      await cubit.resendVerification('a@b.com');

      expect(cubit.state, isA<AuthResendFailure>());
    });
  });

  group('logout', () {
    test('always ends in AuthUnauthenticated', () async {
      repo.loginResult = session();
      await cubit.login(email: 'a@b.com', password: 'secret');
      expect(cubit.state, isA<AuthAuthenticated>());

      await cubit.logout();

      expect(cubit.state, const AuthUnauthenticated());
    });
  });
}
