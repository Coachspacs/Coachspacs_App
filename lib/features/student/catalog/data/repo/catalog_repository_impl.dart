import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';

import 'catalog_repository.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<PaginatedResponse<CatalogCourseDto>> getCourses({
    int? category,
    String? language,
    String? level,
    num? priceMin,
    num? priceMax,
    String? search,
    int? page,
    int? pageSize,
  }) => _guard(
    () => _api.getCatalogCourses(
      category: category,
      language: language,
      level: level,
      priceMin: priceMin,
      priceMax: priceMax,
      search: search,
      page: page,
      pageSize: pageSize,
    ),
  );

  @override
  Future<CourseDetailDto> getCourse(int id) =>
      _guard(() => _api.getCatalogCourse(id));

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
