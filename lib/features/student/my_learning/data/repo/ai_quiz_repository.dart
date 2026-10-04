import 'package:coach_space/features/student/my_learning/data/models/ai_quiz_dtos.dart';

abstract class AIQuizRepository {
  /// Starts async generation; returns the pending quiz to poll.
  Future<AIQuizDto> startQuiz(int courseId, AIQuizStartRequest body);

  /// The student's own quizzes for one course.
  Future<List<AIQuizDto>> listQuizzes(int courseId);

  /// Polls one quiz; once ready the questions come back (never the answers).
  Future<AIQuizDto> getQuiz(int quizId);

  /// Submits answers and reveals correct answers + explanations.
  Future<AIQuizResultDto> submitQuiz(int quizId, AIQuizSubmitRequest body);
}
