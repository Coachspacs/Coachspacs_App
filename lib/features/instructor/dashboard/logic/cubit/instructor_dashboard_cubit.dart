import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/instructor/courses/data/models/instructor_course_dto.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/instructor/dashboard/data/models/instructor_dashboard_dto.dart';
import 'package:coach_space/features/instructor/dashboard/data/repo/instructor_dashboard_repository.dart';

part 'instructor_dashboard_state.dart';

/// Loads the instructor dashboard: the `/api/instructor/dashboard` totals
/// merged with the instructor's own course list (used for the per-status
/// breakdown and "last edited" list whenever the totals payload omits a key).
class InstructorDashboardCubit extends Cubit<InstructorDashboardState> {
  InstructorDashboardCubit({
    required InstructorDashboardRepository dashboardRepository,
    required InstructorCoursesRepository coursesRepository,
  }) : _dashboardRepository = dashboardRepository,
       _coursesRepository = coursesRepository,
       super(const InstructorDashboardInitial());

  final InstructorDashboardRepository _dashboardRepository;
  final InstructorCoursesRepository _coursesRepository;

  Future<void> load() async {
    emit(const InstructorDashboardLoading());
    try {
      final dashboard = await _dashboardRepository.getDashboard();
      final courses = await _loadCourses();
      emit(
        InstructorDashboardSuccess(
          dashboard: dashboard,
          courses: courses,
        ),
      );
    } on NetworkException catch (error) {
      emit(InstructorDashboardFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const InstructorDashboardFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> refresh() => load();

  Future<List<InstructorCourseDto>> _loadCourses() async {
    try {
      final page = await _coursesRepository.getCourses(pageSize: 50);
      return page.results;
    } on NetworkException {
      return const [];
    }
  }
}