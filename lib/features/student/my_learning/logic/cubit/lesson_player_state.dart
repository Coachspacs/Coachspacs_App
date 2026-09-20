part of 'lesson_player_cubit.dart';

sealed class LessonPlayerState {
  const LessonPlayerState();
}

final class LessonPlayerInitial extends LessonPlayerState {
  const LessonPlayerInitial();
}

final class LessonPlayerLoading extends LessonPlayerState {
  const LessonPlayerLoading({required this.enrollmentId, required this.lessonId});

  final int enrollmentId;
  final int lessonId;
}

final class LessonPlayerSuccess extends LessonPlayerState {
  const LessonPlayerSuccess({
    required this.enrollmentId,
    required this.lesson,
    this.isTogglingCompletion = false,
  });

  final int enrollmentId;
  final LessonPlayerDto lesson;
  final bool isTogglingCompletion;

  bool get hasNextLesson => lesson.nextLessonId != null;
  bool get hasPreviousLesson => lesson.previousLessonId != null;

  LessonPlayerSuccess copyWith({bool? isTogglingCompletion}) {
    return LessonPlayerSuccess(
      enrollmentId: enrollmentId,
      lesson: lesson,
      isTogglingCompletion: isTogglingCompletion ?? this.isTogglingCompletion,
    );
  }
}

final class LessonPlayerFailure extends LessonPlayerState {
  const LessonPlayerFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}