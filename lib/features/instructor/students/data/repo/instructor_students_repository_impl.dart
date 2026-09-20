import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/instructor/students/data/models/instructor_student_dto.dart';

import 'instructor_students_repository.dart';

class InstructorStudentsRepositoryImpl implements InstructorStudentsRepository {
  InstructorStudentsRepositoryImpl({required ApiService apiService})
    : _api = apiService;

  final ApiService _api;

  @override
  Future<PaginatedResponse<InstructorStudentDto>> getCourseStudents(
    int courseId, {
    int page = 1,
    int pageSize = 50,
  }) => _guard(
    () => _api.getInstructorCourseStudents(
      courseId,
      page: page,
      pageSize: pageSize,
    ),
  );

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}