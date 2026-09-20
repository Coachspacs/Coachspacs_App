part of 'instructor_dashboard_cubit.dart';

sealed class InstructorDashboardState {
  const InstructorDashboardState();
}

final class InstructorDashboardInitial extends InstructorDashboardState {
  const InstructorDashboardInitial();
}

final class InstructorDashboardLoading extends InstructorDashboardState {
  const InstructorDashboardLoading();
}

final class InstructorDashboardSuccess extends InstructorDashboardState {
  const InstructorDashboardSuccess({
    required this.dashboard,
    required this.courses,
  });

  /// Totals reported by `/api/instructor/dashboard` (may be partial).
  final InstructorDashboardDto dashboard;

  /// The instructor's own courses, used for the status breakdown and the
  /// "last edited" list.
  final List<InstructorCourseDto> courses;

  List<InstructorCourseDto> get recentCourses {
    final sorted = [...courses]
      ..sort((a, b) {
        final aUpdated = DateTime.tryParse(a.updatedAt ?? '');
        final bUpdated = DateTime.tryParse(b.updatedAt ?? '');
        return (bUpdated ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(
          aUpdated ?? DateTime.fromMillisecondsSinceEpoch(0),
        );
      });
    return sorted.take(3).toList();
  }

  int get totalCourses =>
      dashboard.totalCourses ??
      courses.length;

  int get underReview =>
      dashboard.pendingCount ??
      _countWhere((c) => c.status == 'pending' || c.status == 'pending_review');

  int get drafts =>
      dashboard.draftsCount ?? _countWhere((c) => c.status == 'draft');

  int get published =>
      dashboard.publishedCount ??
      _countWhere((c) => c.status == 'published');

  int get totalStudents => dashboard.totalStudents ?? 0;

  int _countWhere(bool Function(InstructorCourseDto) test) =>
      courses.where(test).length;
}

final class InstructorDashboardFailure extends InstructorDashboardState {
  const InstructorDashboardFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}