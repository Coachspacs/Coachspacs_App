part of 'my_learning_cubit.dart';

sealed class MyLearningState {
  const MyLearningState();
}

final class MyLearningInitial extends MyLearningState {
  const MyLearningInitial();
}

final class MyLearningLoading extends MyLearningState {
  const MyLearningLoading();
}

final class MyLearningSuccess extends MyLearningState {
  const MyLearningSuccess({
    required this.enrollments,
    required this.certificates,
  });

  final List<EnrollmentDto> enrollments;
  final List<CertificateDto> certificates;
}

/// No enrollments yet (certificates may still be present).
final class MyLearningEmpty extends MyLearningState {
  const MyLearningEmpty({required this.certificates});

  final List<CertificateDto> certificates;
}

final class MyLearningFailure extends MyLearningState {
  const MyLearningFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}
