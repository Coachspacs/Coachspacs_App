import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/my_learning/data/models/ai_quiz_dtos.dart';
import 'package:coach_space/features/student/my_learning/data/repo/ai_quiz_repository.dart';

part 'ai_quiz_state.dart';

/// Manages the AI practice-quiz flow for one course: listing previously
/// generated quizzes, starting generation (202 + poll until `ready`), taking
/// the quiz and submitting it for the scored result.
class AIQuizCubit extends Cubit<AIQuizState> {
  AIQuizCubit({required AIQuizRepository repository})
    : _repository = repository,
      super(const AIQuizInitial());

  static const Duration _pollInterval = Duration(milliseconds: 2500);

  /// `60s / 2.5s` — after this many polls generation is treated as failed.
  static const int _maxPollAttempts = 24;

  final AIQuizRepository _repository;
  int? _courseId;

  /// Bumped to invalidate an in-flight polling loop (user went back to the
  /// list or started a new generation); the loop bails when its token is stale.
  int _pollToken = 0;

  /// Loads the course's existing quizzes.
  Future<void> load(int? courseId) async {
    _courseId = courseId;
    _pollToken++;
    final id = courseId;
    if (id == null) {
      emit(
        const AIQuizFailure(
          kind: FailureKind.notFound,
          message: 'Missing course for AI quiz.',
          fromList: true,
        ),
      );
      return;
    }

    emit(const AIQuizListLoading());
    try {
      final quizzes = await _repository.listQuizzes(id);
      emit(AIQuizListLoaded(quizzes: quizzes));
    } on NetworkException catch (error) {
      if (isClosed) return;
      emit(
        AIQuizFailure(kind: error.kind, message: error.message, fromList: true),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        const AIQuizFailure(
          kind: FailureKind.unknown,
          message: NetworkException.fallbackMessage,
          fromList: true,
        ),
      );
    }
  }

  Future<void> refresh() => load(_courseId);

  /// Starts generating a new quiz, then polls until `ready`/`failed`.
  Future<void> createQuiz() async {
    final courseId = _courseId;
    if (courseId == null) return;

    final token = ++_pollToken;
    emit(const AIQuizStarting());
    try {
      final pending = await _repository.startQuiz(
        courseId,
        const AIQuizStartRequest(),
      );
      final ready = await _pollUntilReady(pending, token);
      if (isClosed || _pollToken != token) return;
      emit(AIQuizReady(quiz: ready));
    } on NetworkException catch (error) {
      if (isClosed || _pollToken != token) return;
      emit(AIQuizFailure(kind: error.kind, message: error.message));
    } catch (_) {
      if (isClosed || _pollToken != token) return;
      emit(
        const AIQuizFailure(
          kind: FailureKind.unknown,
          message: NetworkException.fallbackMessage,
        ),
      );
    }
  }

  /// Opens a `ready` quiz from the list — refetches it so the questions are
  /// always present (list responses may omit them).
  Future<void> openQuiz(AIQuizDto quiz) async {
    try {
      emit(const AIQuizListLoading());
      final full = await _repository.getQuiz(quiz.id);
      if (isClosed) return;
      if (full.isPending) {
        await _resumePolling(full);
        return;
      }
      if (full.isFailed) {
        await createQuiz();
        return;
      }
      emit(AIQuizReady(quiz: full));
    } on NetworkException catch (error) {
      if (isClosed) return;
      emit(AIQuizFailure(kind: error.kind, message: error.message));
    } catch (_) {
      if (isClosed) return;
      emit(
        const AIQuizFailure(
          kind: FailureKind.unknown,
          message: NetworkException.fallbackMessage,
        ),
      );
    }
  }

  /// Resumes polling a quiz that is still generating.
  Future<void> pollQuiz(AIQuizDto quiz) => _resumePolling(quiz);

  Future<void> _resumePolling(AIQuizDto quiz) async {
    final token = ++_pollToken;
    try {
      final ready = await _pollUntilReady(quiz, token);
      if (isClosed || _pollToken != token) return;
      emit(AIQuizReady(quiz: ready));
    } on NetworkException catch (error) {
      if (isClosed || _pollToken != token) return;
      emit(AIQuizFailure(kind: error.kind, message: error.message));
    } catch (_) {
      if (isClosed || _pollToken != token) return;
      emit(
        const AIQuizFailure(
          kind: FailureKind.unknown,
          message: NetworkException.fallbackMessage,
        ),
      );
    }
  }

  /// Polls [initial] every [_pollInterval] until `ready` or `failed`.
  ///
  /// Throws [NetworkException] if generation fails, times out, or a poll
  /// request itself fails. Returns early (without emitting) when the token is
  /// stale or the cubit is closed.
  Future<AIQuizDto> _pollUntilReady(AIQuizDto initial, int token) async {
    var quiz = initial;
    for (var attempt = 1; attempt <= _maxPollAttempts; attempt++) {
      if (isClosed || _pollToken != token) return quiz;

      if (!_isTerminal(quiz)) {
        emit(
          AIQuizPolling(
            quiz: quiz,
            attempt: attempt,
            maxAttempts: _maxPollAttempts,
          ),
        );
      }

      final latest = await _repository.getQuiz(quiz.id);
      if (latest.isReady && latest.hasQuestions) return latest;
      if (latest.isFailed) {
        throw NetworkException(
          kind: FailureKind.businessRejection,
          message: (latest.detail?.isNotEmpty ?? false) ? latest.detail! : '',
        );
      }
      quiz = latest;
      await Future<void>.delayed(_pollInterval);
    }

    throw const NetworkException(
      kind: FailureKind.unknown,
      message: NetworkException.fallbackMessage,
    );
  }

  bool _isTerminal(AIQuizDto quiz) => quiz.isReady || quiz.isFailed;

  /// Records (or changes) the selected option for one question.
  void selectAnswer(int questionId, int optionIndex) {
    final state = this.state;
    if (state is! AIQuizReady) return;
    final answers = Map<int, int>.of(state.answers);
    if (answers[questionId] == optionIndex) {
      answers.remove(questionId);
    } else {
      answers[questionId] = optionIndex;
    }
    emit(state.copyWith(answers: answers));
  }

  /// Submits the recorded answers (unanswered questions are simply omitted —
  /// the server counts them as wrong) and emits the scored result.
  Future<void> submit() async {
    final state = this.state;
    if (state is! AIQuizReady || state.quiz.questions.isEmpty) return;

    emit(AIQuizSubmitting(quiz: state.quiz, answers: state.answers));
    try {
      final result = await _repository.submitQuiz(
        state.quiz.id,
        AIQuizSubmitRequest(
          answers: state.answers.entries
              .map(
                (entry) => AIQuizAnswer(
                  questionId: entry.key,
                  selectedAnswer: entry.value,
                ),
              )
              .toList(),
        ),
      );
      if (isClosed) return;
      emit(AIQuizResultLoaded(result: result, quiz: state.quiz));
    } on NetworkException catch (error) {
      if (isClosed) return;
      emit(
        AIQuizFailure(
          kind: error.kind,
          message: error.message,
          quiz: state.quiz,
          answers: state.answers,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        AIQuizFailure(
          kind: FailureKind.unknown,
          message: NetworkException.fallbackMessage,
          quiz: state.quiz,
          answers: state.answers,
        ),
      );
    }
  }

  /// Retries based on where the last failure came from: submit failure with
  /// quiz context → back to taking the quiz; list failure → reload the list;
  /// otherwise → regenerate.
  void retry() {
    final state = this.state;
    if (state is! AIQuizFailure) return;
    final quiz = state.quiz;
    if (quiz != null) {
      emit(AIQuizReady(quiz: quiz, answers: state.answers));
      return;
    }
    if (state.fromList) {
      load(_courseId);
      return;
    }
    createQuiz();
  }

  /// Leaves the take/result phase and reloads the quiz list.
  Future<void> backToList() => load(_courseId);
}
