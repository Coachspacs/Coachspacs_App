import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/auth/data/models/change_password_request.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository.dart';

part 'security_state.dart';

/// Wires the security settings form to `PUT /api/auth/password/change`.
class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit(this._repository) : super(const SecurityInitial());

  final AuthRepository _repository;

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(const SecuritySaving());
    try {
      await _repository.changePassword(
        ChangePasswordRequest(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ),
      );
      emit(const SecuritySuccess());
      return true;
    } on NetworkException catch (error) {
      emit(SecurityFailure(kind: error.kind, message: error.message));
      return false;
    } catch (_) {
      emit(
        const SecurityFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
      return false;
    }
  }
}
