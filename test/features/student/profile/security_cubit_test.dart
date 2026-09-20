import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/auth/data/models/change_password_request.dart';
import 'package:coach_space/features/auth/data/models/forgot_password_request.dart';
import 'package:coach_space/features/auth/data/models/login_request.dart';
import 'package:coach_space/features/auth/data/models/register_request.dart';
import 'package:coach_space/features/auth/data/models/register_response.dart';
import 'package:coach_space/features/auth/data/models/resend_verification_request.dart';
import 'package:coach_space/features/auth/data/models/reset_password_request.dart';
import 'package:coach_space/features/auth/data/models/user_session.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository.dart';
import 'package:coach_space/features/student/profile/logic/cubit/security_cubit.dart';

class _FakeAuthRepository implements AuthRepository {
  Object? changePasswordError;
  final List<ChangePasswordRequest> requests = [];

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    requests.add(request);
    if (changePasswordError != null) throw changePasswordError!;
  }

  @override
  Future<UserSession> login(LoginRequest request) async =>
      throw UnimplementedError();

  @override
  Future<RegisterResponse> register(RegisterRequest request) async =>
      throw UnimplementedError();

  @override
  Future<void> logout() async {}

  @override
  Future<void> forgotPassword(ForgotPasswordRequest request) async {}

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {}

  @override
  Future<void> verifyEmail({required String uid, required String token}) async {}

  @override
  Future<void> resendEmailVerification(
    ResendVerificationRequest request,
  ) async {}

  @override
  Future<UserSession?> restoreSession() async => null;

  @override
  Future<void> clearSession() async {}
}

void main() {
  late _FakeAuthRepository repository;
  late SecurityCubit cubit;

  setUp(() {
    repository = _FakeAuthRepository();
    cubit = SecurityCubit(repository);
  });

  tearDown(() => cubit.close());

  test('changePassword emits Saving then Success and returns true', () async {
    final emissions = <SecurityState>[];
    final subscription = cubit.stream.listen(emissions.add);

    final result = await cubit.changePassword(
      currentPassword: 'old-secret',
      newPassword: 'new-secret',
    );
    await Future<void>.delayed(Duration.zero);

    expect(result, isTrue);
    expect(emissions, [isA<SecuritySaving>(), isA<SecuritySuccess>()]);
    expect(repository.requests.single.currentPassword, 'old-secret');
    expect(repository.requests.single.newPassword, 'new-secret');

    await subscription.cancel();
  });

  test('changePassword emits SecurityFailure with the kind and returns false', () async {
    repository.changePasswordError = const NetworkException(
      kind: FailureKind.validation,
      message: 'Password is too weak',
    );

    final result = await cubit.changePassword(
      currentPassword: 'old-secret',
      newPassword: 'weak',
    );

    expect(result, isFalse);
    expect(cubit.state, isA<SecurityFailure>());
    final failure = cubit.state as SecurityFailure;
    expect(failure.kind, FailureKind.validation);
    expect(failure.message, 'Password is too weak');
  });
}
