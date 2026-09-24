import 'package:coach_space/core/auth/guest_session.dart';
import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

import '../models/category.dart';
import '../models/home_data.dart';
import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required ApiService apiService}) : _api = apiService;

  final ApiService _api;

  @override
  Future<List<Category>> getCategories() => _guard(() async {
    final dtos = await _api.getCategories();
    return dtos
        .map(
          (dto) => Category(
            id: dto.id.toString(),
            name: dto.name,
            icon: dto.icon,
          ),
        )
        .toList();
  });

  @override
  Future<HomeData> getHomeData() async {
    final categories = await getCategories();
    final recommended = await _loadRecommendedCourses();
    final continueEnrollment = await _loadContinueEnrollment();

    return HomeData(
      categories: categories,
      recommendedCourses: recommended,
      continueEnrollment: continueEnrollment,
    );
  }

  Future<List<CatalogCourseDto>> _loadRecommendedCourses() =>
      NetworkException.guard(
        () => _api.getCatalogCourses(
          ordering: '-created_at',
          page: 1,
          pageSize: 6,
        ).then((page) => page.results),
      );

  Future<EnrollmentDto?> _loadContinueEnrollment() async {
    if (GuestSession.isGuest) return null;

    try {
      final page = await NetworkException.guard(
        () => _api.getEnrollments(1, 20),
      );
      final results = [...page.results]
        ..sort((a, b) => b.enrolledAt.compareTo(a.enrolledAt));
      for (final enrollment in results) {
        if (!enrollment.isCompleted) return enrollment;
      }
      return results.isEmpty ? null : results.first;
    } on NetworkException {
      // Continue-learning is optional; never fail the whole home screen.
      return null;
    }
  }

  Future<T> _guard<T>(Future<T> Function() action) =>
      NetworkException.guard(action);
}
