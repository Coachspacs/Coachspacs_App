import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

import 'enrollment_repository.dart';

class EnrollmentRepositoryImpl implements EnrollmentRepository {
  EnrollmentRepositoryImpl({required ApiService apiService})
    : _api = apiService;

  final ApiService _api;

  @override
  Future<PaginatedResponse<EnrollmentDto>> getEnrollments({
    int page = 1,
    int pageSize = 20,
  }) => _guard(() => _api.getEnrollments(page, pageSize));

  @override
  Future<LessonPlayerDto> getLesson(int enrollmentId, int lessonId) =>
      _guard(() => _api.getEnrollmentLesson(enrollmentId, lessonId));

  @override
  Future<void> markLessonComplete(int enrollmentId, int lessonId) =>
      _guard(() => _api.markLessonComplete(enrollmentId, lessonId));

  @override
  Future<void> markLessonIncomplete(int enrollmentId, int lessonId) =>
      _guard(() => _api.markLessonIncomplete(enrollmentId, lessonId));

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
