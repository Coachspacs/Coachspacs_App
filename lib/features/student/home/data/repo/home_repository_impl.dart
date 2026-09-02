import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';


import '../models/category.dart';
import '../models/home_data.dart';
import '../models/mock_home_data.dart';
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
    return HomeData(
      categories: categories,
      featuredCourses: MockHomeData.featuredCourses,
      trendingCourses: MockHomeData.trendingCourses,
    );
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
