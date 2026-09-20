part of 'dashboard_cubit.dart';

sealed class DashboardState {
  const DashboardState();
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardSuccess extends DashboardState {
  const DashboardSuccess({
    required this.userName,
    required this.enrollments,
    required this.totalEnrollments,
  });

  final String userName;
  final List<EnrollmentDto> enrollments;
  final int totalEnrollments;
}

final class DashboardFailure extends DashboardState {
  const DashboardFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}
