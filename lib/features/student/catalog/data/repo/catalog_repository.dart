import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';

abstract class CatalogRepository {
  Future<List<CategoryDto>> getCategories();

  Future<PaginatedResponse<CatalogCourseDto>> getCourses({
    int? category,
    String? language,
    String? level,
    num? priceMin,
    num? priceMax,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  });

  Future<CourseDetailDto> getCourse(int id);

  /// Downloads a course material's bytes (redirects to the signed asset).
  Future<List<int>> downloadAttachment(int id);
}
