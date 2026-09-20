import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/instructor/dashboard/data/models/instructor_dashboard_dto.dart';

import 'instructor_dashboard_repository.dart';

class InstructorDashboardRepositoryImpl
    implements InstructorDashboardRepository {
  InstructorDashboardRepositoryImpl({required ApiService apiService})
    : _api = apiService;

  final ApiService _api;

  @override
  Future<InstructorDashboardDto> getDashboard() =>
      _guard(() => _api.getInstructorDashboard());

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}