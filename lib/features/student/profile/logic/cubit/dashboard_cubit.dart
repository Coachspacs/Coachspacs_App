import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/profile_repository.dart';

part 'dashboard_state.dart';

/// Loads the data backing the student dashboard: enrollments (stats and
/// continue-learning) plus the current user's name.
class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({
    required EnrollmentRepository enrollmentRepository,
    required ProfileRepository profileRepository,
  }) : _enrollmentRepository = enrollmentRepository,
       _profileRepository = profileRepository,
       super(const DashboardInitial());

  final EnrollmentRepository _enrollmentRepository;
  final ProfileRepository _profileRepository;

  Future<void> load() async {
    emit(const DashboardLoading());
    try {
      final page = await _enrollmentRepository.getEnrollments(pageSize: 50);
      final userName = await _loadUserName();

      emit(
        DashboardSuccess(
          userName: userName,
          enrollments: page.results,
          totalEnrollments: page.count,
        ),
      );
    } on NetworkException catch (error) {
      emit(DashboardFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const DashboardFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> refresh() => load();

  Future<String> _loadUserName() async {
    try {
      final profile = await _profileRepository.getProfile();
      return profile.fullName?.trim() ?? '';
    } on NetworkException {
      return '';
    }
  }
}
