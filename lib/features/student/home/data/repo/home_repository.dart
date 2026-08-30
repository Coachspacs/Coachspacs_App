
import '../models/category.dart';
import '../models/home_data.dart';

abstract interface class HomeRepository {
  Future<List<Category>> getCategories();

  /// Returns the full home aggregate: API-backed categories plus local mock
  /// courses (no course endpoints exist on the backend yet).
  Future<HomeData> getHomeData();
}
