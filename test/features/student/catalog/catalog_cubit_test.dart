import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';
import 'package:coach_space/features/student/catalog/data/repo/catalog_repository.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/catalog_cubit.dart';

typedef _CoursesCall = ({
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

CatalogCourseDto _course(int id) => CatalogCourseDto(
  id: id,
  title: 'Course $id',
  description: 'Description $id',
  category: const CategoryDto(id: 1, name: 'Development'),
  instructor: const InstructorSummaryDto(id: 9, fullName: 'Coach', avatar: ''),
  level: 'beginner',
  language: 'en',
  price: '29.99',
  isFree: false,
  coverImage: '',
  createdAt: DateTime(2026, 1, 1),
);

class _FakeCatalogRepository implements CatalogRepository {
  List<CategoryDto> categories = const [];
  Object? categoriesError;

  final List<_CoursesCall> courseRequests = [];
  final List<PaginatedResponse<CatalogCourseDto>> coursePages = [];
  Object? coursesError;

  @override
  Future<List<CategoryDto>> getCategories() async {
    if (categoriesError != null) throw categoriesError!;
    return categories;
  }

  @override
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
  }) async {
    courseRequests.add((
      category: category,
      language: language,
      level: level,
      priceMin: priceMin,
      priceMax: priceMax,
      search: search,
      ordering: ordering,
      page: page,
      pageSize: pageSize,
    ));
    if (coursesError != null) throw coursesError!;
    return coursePages[(page ?? 1) - 1];
  }

  @override
  Future<CourseDetailDto> getCourse(int id) async =>
      throw UnimplementedError();
}

void main() {
  late _FakeCatalogRepository repository;
  late CatalogCubit cubit;

  setUp(() {
    repository = _FakeCatalogRepository();
    cubit = CatalogCubit(repository);
  });

  tearDown(() => cubit.close());

  group('CatalogCubit.load', () {
    test('emits Loading then Success with courses, categories and count', () async {
      repository.categories = const [
        CategoryDto(id: 1, name: 'Development'),
        CategoryDto(id: 2, name: 'Design'),
      ];
      repository.coursePages.add(
        PaginatedResponse(
          count: 12,
          next: 'http://test.local/api/catalog/courses?page=2',
          results: [_course(1), _course(2)],
        ),
      );
      final emissions = <CatalogState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<CatalogLoading>(), isA<CatalogSuccess>()]);
      final state = cubit.state as CatalogSuccess;
      expect(state.courses.map((course) => course.id), [1, 2]);
      expect(state.categories, hasLength(2));
      expect(state.totalCount, 12);
      expect(state.hasMore, isTrue);
      expect(state.isEmpty, isFalse);

      await subscription.cancel();
    });

    test('applies every filter to the repository request', () async {
      repository.coursePages.add(
        const PaginatedResponse(count: 0, results: []),
      );
      const filters = CatalogFilters(
        category: 3,
        language: 'en',
        level: 'beginner',
        priceMin: 10,
        priceMax: 50,
        search: 'flutter',
        ordering: '-created_at',
      );

      await cubit.load(filters: filters);

      final call = repository.courseRequests.single;
      expect(call.category, 3);
      expect(call.language, 'en');
      expect(call.level, 'beginner');
      expect(call.priceMin, 10);
      expect(call.priceMax, 50);
      expect(call.search, 'flutter');
      expect(call.ordering, '-created_at');
      expect(call.page, 1);
      expect(call.pageSize, 10);
      expect(cubit.filters, filters);
    });

    test('emits CatalogFailure with kind and message on NetworkException', () async {
      repository.coursesError = const NetworkException(
        kind: FailureKind.businessRejection,
        message: 'Course is unavailable',
      );

      await cubit.load();

      expect(cubit.state, isA<CatalogFailure>());
      final failure = cubit.state as CatalogFailure;
      expect(failure.kind, FailureKind.businessRejection);
      expect(failure.message, 'Course is unavailable');
    });

    test('keeps loading courses when the categories request fails', () async {
      repository.categoriesError = const NetworkException(
        kind: FailureKind.serverError,
        message: 'boom',
      );
      repository.coursePages.add(
        PaginatedResponse(count: 1, results: [_course(1)]),
      );

      await cubit.load();

      final state = cubit.state as CatalogSuccess;
      expect(state.courses, hasLength(1));
      expect(state.categories, isEmpty);
    });
  });

  group('CatalogCubit.loadMore', () {
    test('appends the next page and updates hasMore', () async {
      repository.coursePages.addAll([
        PaginatedResponse(
          count: 12,
          next: 'http://test.local/api/catalog/courses?page=2',
          results: [for (var id = 1; id <= 10; id++) _course(id)],
        ),
        PaginatedResponse(
          count: 12,
          results: [_course(11), _course(12)],
        ),
      ]);

      await cubit.load();
      expect((cubit.state as CatalogSuccess).hasMore, isTrue);

      await cubit.loadMore();

      final state = cubit.state as CatalogSuccess;
      expect(
        state.courses.map((course) => course.id),
        [for (var id = 1; id <= 12; id++) id],
      );
      expect(state.totalCount, 12);
      expect(state.hasMore, isFalse);
      expect(state.isLoadingMore, isFalse);
      expect(repository.courseRequests.map((call) => call.page), [1, 2]);
    });

    test('does nothing when the current page has no more results', () async {
      repository.coursePages.add(
        PaginatedResponse(count: 1, results: [_course(1)]),
      );

      await cubit.load();
      await cubit.loadMore();

      expect(repository.courseRequests, hasLength(1));
    });
  });

  group('CatalogCubit.refresh', () {
    test('reuses the currently active filters', () async {
      repository.coursePages.addAll([
        const PaginatedResponse(count: 0, results: []),
        const PaginatedResponse(count: 0, results: []),
      ]);
      const filters = CatalogFilters(category: 4, search: 'ux');

      await cubit.load(filters: filters);
      await cubit.refresh();

      expect(repository.courseRequests, hasLength(2));
      final call = repository.courseRequests.last;
      expect(call.category, 4);
      expect(call.search, 'ux');
      expect(call.page, 1);
      expect(cubit.filters, filters);
    });
  });
}
