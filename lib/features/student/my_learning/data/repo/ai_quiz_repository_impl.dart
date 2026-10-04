import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/my_learning/data/models/ai_quiz_dtos.dart';

import 'ai_quiz_repository.dart';

class AIQuizRepositoryImpl implements AIQuizRepository {
  AIQuizRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<AIQuizDto> startQuiz(int courseId, AIQuizStartRequest body) =>
      _guard(() => _api.startAIQuiz(courseId, body));

  @override
  Future<List<AIQuizDto>> listQuizzes(int courseId) =>
      _guard(() => _api.getCourseAIQuizzes(courseId));

  @override
  Future<AIQuizDto> getQuiz(int quizId) =>
      _guard(() => _api.getAIQuiz(quizId));

  @override
  Future<AIQuizResultDto> submitQuiz(int quizId, AIQuizSubmitRequest body) =>
      _guard(() => _api.submitAIQuiz(quizId, body));

  Future<T> _guard<T>(Future<T> Function() request) =>
      NetworkException.guard(request);
}
