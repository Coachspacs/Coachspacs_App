import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';

part 'browse_courses_state.dart';

/// Backs the "browse my courses" list with `GET /api/enrollments`.
class BrowseCoursesCubit extends Cubit<BrowseCoursesState> {
  BrowseCoursesCubit(this._repository) : super(const BrowseCoursesInitial());

  final EnrollmentRepository _repository;

  Future<void> load() async {
    emit(const BrowseCoursesLoading());
    try {
      final page = await _repository.getEnrollments(pageSize: 50);
      if (page.results.isEmpty) {
        emit(const BrowseCoursesEmpty());
      } else {
        emit(BrowseCoursesSuccess(page.results));
      }
    } on NetworkException catch (error) {
      emit(BrowseCoursesFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const BrowseCoursesFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> refresh() => load();
}
