import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';

part 'lesson_player_state.dart';

/// Loads a single lesson for the student's enrollment
/// (`GET /api/enrollments/{id}/lessons/{lessonId}`) and toggles its completion
/// state (`POST`/`DELETE .../complete`).
class LessonPlayerCubit extends Cubit<LessonPlayerState> {
  LessonPlayerCubit({required EnrollmentRepository enrollmentRepository})
    : _enrollmentRepository = enrollmentRepository,
      super(const LessonPlayerInitial());

  final EnrollmentRepository _enrollmentRepository;

  Future<void> load({required int enrollmentId, required int lessonId}) async {
    emit(LessonPlayerLoading(enrollmentId: enrollmentId, lessonId: lessonId));
    try {
      final lesson = await _enrollmentRepository.getLesson(enrollmentId, lessonId);
      emit(LessonPlayerSuccess(enrollmentId: enrollmentId, lesson: lesson));
    } on NetworkException catch (error) {
      emit(LessonPlayerFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const LessonPlayerFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  /// Moves to an adjacent lesson and reloads it.
  Future<void> openLesson(int enrollmentId, int lessonId) =>
      load(enrollmentId: enrollmentId, lessonId: lessonId);

  Future<void> markComplete() => _setComplete(true);

  Future<void> markIncomplete() => _setComplete(false);

  Future<void> _setComplete(bool complete) async {
    final current = state;
    if (current is! LessonPlayerSuccess || current.isTogglingCompletion) return;

    emit(current.copyWith(isTogglingCompletion: true));
    try {
      if (complete) {
        await _enrollmentRepository.markLessonComplete(
          current.enrollmentId,
          current.lesson.id,
        );
      } else {
        await _enrollmentRepository.markLessonIncomplete(
          current.enrollmentId,
          current.lesson.id,
        );
      }
      emit(current.copyWith(isTogglingCompletion: false));
    } on NetworkException catch (error) {
      emit(LessonPlayerFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const LessonPlayerFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}