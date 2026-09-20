import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/data/repo/catalog_repository.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository.dart';

part 'course_details_state.dart';

/// Loads a single course from `GET /api/catalog/courses/{id}`, checks whether
/// the student is already enrolled (from `GET /api/enrollments`) and adds the
/// course to the cart (`POST /api/cart/items`).
class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit({
    required CatalogRepository catalogRepository,
    required EnrollmentRepository enrollmentRepository,
    required CartRepository cartRepository,
  }) : _catalogRepository = catalogRepository,
       _enrollmentRepository = enrollmentRepository,
       _cartRepository = cartRepository,
       super(const CourseDetailsInitial());

  final CatalogRepository _catalogRepository;
  final EnrollmentRepository _enrollmentRepository;
  final CartRepository _cartRepository;

  /// Used when the route is opened without a valid course id.
  void emitInvalidArguments() => emit(
    const CourseDetailsFailure(
      kind: FailureKind.notFound,
      message: '',
    ),
  );

  Future<void> load(int courseId) async {
    emit(const CourseDetailsLoading());
    try {
      final course = await _catalogRepository.getCourse(courseId);
      final enrollment = await _findEnrollment(courseId);
      emit(CourseDetailsSuccess(course: course, enrollment: enrollment));
    } on NetworkException catch (error) {
      emit(CourseDetailsFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const CourseDetailsFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<EnrollmentDto?> _findEnrollment(int courseId) async {
    try {
      final page = await _enrollmentRepository.getEnrollments(pageSize: 100);
      for (final enrollment in page.results) {
        if (enrollment.course.id == courseId) return enrollment;
      }
      return null;
    } on NetworkException {
      return null;
    }
  }

  /// Returns `true` when the course was added to the cart.
  Future<bool> addToCart() async {
    final current = state;
    if (current is! CourseDetailsSuccess || current.isBusy) {
      return false;
    }

    emit(current.copyWith(isAddingToCart: true));
    try {
      await _cartRepository.addItem(current.course.id);
      emit(current.copyWith(isAddingToCart: false));
      return true;
    } on NetworkException {
      emit(current.copyWith(isAddingToCart: false));
      return false;
    }
  }

  /// Enrolls the student directly in a free course
  /// (`POST /api/enrollments/free`), bypassing cart and checkout. On success the
  /// enrollment is reloaded so the UI can switch to the "Continue" state.
  Future<bool> enrollFree() async {
    final current = state;
    if (current is! CourseDetailsSuccess || current.isBusy) {
      return false;
    }

    emit(current.copyWith(isEnrollingFree: true));
    try {
      await _enrollmentRepository.enrollFree(current.course.id);
      final enrollment = await _findEnrollment(current.course.id);
      final latest = state;
      if (latest is CourseDetailsSuccess) {
        emit(
          latest.copyWith(
            enrollment: enrollment,
            isEnrollingFree: false,
          ),
        );
      }
      return true;
    } on NetworkException {
      final latest = state;
      if (latest is CourseDetailsSuccess) {
        emit(latest.copyWith(isEnrollingFree: false));
      }
      return false;
    }
  }
}
