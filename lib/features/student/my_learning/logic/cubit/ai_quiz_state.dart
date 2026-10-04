part of 'ai_quiz_cubit.dart';

sealed class AIQuizState {
  const AIQuizState();
}

final class AIQuizInitial extends AIQuizState {
  const AIQuizInitial();
}

/// Fetching the course's existing quizzes.
final class AIQuizListLoading extends AIQuizState {
  const AIQuizListLoading();
}

/// Quizzes shown on the entry phase of the screen.
final class AIQuizListLoaded extends AIQuizState {
  const AIQuizListLoaded({required this.quizzes});

  final List<AIQuizDto> quizzes;
}

/// `POST` sent, waiting for the pending quiz (HTTP 202).
final class AIQuizStarting extends AIQuizState {
  const AIQuizStarting();
}

/// Polling `getQuiz` until the quiz is `ready` (or `failed`).
final class AIQuizPolling extends AIQuizState {
  const AIQuizPolling({
    required this.quiz,
    required this.attempt,
    required this.maxAttempts,
  });

  final AIQuizDto quiz;
  final int attempt;
  final int maxAttempts;
}

/// Quiz generated with questions; also the "taking" phase (answers live here
/// so navigation never drops them).
final class AIQuizReady extends AIQuizState {
  const AIQuizReady({required this.quiz, this.answers = const {}});

  final AIQuizDto quiz;

  /// `questionId → selected option index`.
  final Map<int, int> answers;

  int get answeredCount => answers.length;

  AIQuizReady copyWith({Map<int, int>? answers}) =>
      AIQuizReady(quiz: quiz, answers: answers ?? this.answers);
}

/// `POST submit` in flight.
final class AIQuizSubmitting extends AIQuizState {
  const AIQuizSubmitting({required this.quiz, required this.answers});

  final AIQuizDto quiz;
  final Map<int, int> answers;
}

/// Scored result with the quiz for option text / explanations.
final class AIQuizResultLoaded extends AIQuizState {
  const AIQuizResultLoaded({required this.result, required this.quiz});

  final AIQuizResultDto result;
  final AIQuizDto quiz;
}

final class AIQuizFailure extends AIQuizState {
  const AIQuizFailure({
    required this.kind,
    required this.message,
    this.quiz,
    this.answers = const {},
    this.fromList = false,
  });

  final FailureKind kind;
  final String message;

  /// Present when the failure happened while submitting — the previous phase
  /// can be restored on retry.
  final AIQuizDto? quiz;
  final Map<int, int> answers;

  /// `true` when the failure happened while loading the list.
  final bool fromList;
}
