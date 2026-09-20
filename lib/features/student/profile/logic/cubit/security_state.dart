part of 'security_cubit.dart';

sealed class SecurityState {
  const SecurityState();
}

final class SecurityInitial extends SecurityState {
  const SecurityInitial();
}

final class SecuritySaving extends SecurityState {
  const SecuritySaving();
}

final class SecuritySuccess extends SecurityState {
  const SecuritySuccess();
}

final class SecurityFailure extends SecurityState {
  const SecurityFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}
