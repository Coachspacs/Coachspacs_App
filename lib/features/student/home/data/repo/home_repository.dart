import 'package:coach_space/features/student/home/data/models/category.dart';
import 'package:coach_space/features/student/home/data/models/home_data.dart';

abstract interface class HomeRepository {
  Future<List<Category>> getCategories();

  /// Categories + recommended catalog courses, plus the student's most recent
  /// in-progress enrollment (skipped for guests).
  Future<HomeData> getHomeData();
}
