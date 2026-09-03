import 'package:coach_space/core/networking/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'catalog request sends every supplied filter with its API name',
    () async {
      late RequestOptions request;
      final dio = Dio()
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              request = options;
              handler.resolve(
                Response(
                  requestOptions: options,
                  statusCode: 200,
                  data: const {'count': 0, 'results': []},
                ),
              );
            },
          ),
        );

      final api = ApiService(dio);
      final response = await api.getCatalogCourses(
        category: 7,
        language: 'ar',
        level: 'beginner',
        priceMin: 10,
        priceMax: 25.5,
        search: 'flutter',
        page: 2,
        pageSize: 12,
      );

      expect(response.count, 0);
      expect(request.method, 'GET');
      expect(request.path, 'api/catalog/courses');
      expect(request.queryParameters, {
        'category': 7,
        'language': 'ar',
        'level': 'beginner',
        'price_min': 10,
        'price_max': 25.5,
        'search': 'flutter',
        'page': 2,
        'page_size': 12,
      });
    },
  );

  test('lesson completion uses the documented nested resource path', () async {
    late RequestOptions request;
    final dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            request = options;
            handler.resolve(Response(requestOptions: options, statusCode: 200));
          },
        ),
      );

    await ApiService(dio).markLessonComplete(4, 9);

    expect(request.method, 'POST');
    expect(request.path, 'api/enrollments/4/lessons/9/complete');
  });
}
