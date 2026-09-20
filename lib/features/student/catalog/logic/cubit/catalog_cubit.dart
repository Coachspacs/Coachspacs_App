import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';
import 'package:coach_space/features/student/catalog/data/repo/catalog_repository.dart';

part 'catalog_state.dart';

/// Query parameters applied to `GET /api/catalog/courses`.
class CatalogFilters extends Equatable {
  const CatalogFilters({
    this.category,
    this.language,
    this.level,
    this.priceMin,
    this.priceMax,
    this.search,
    this.ordering,
  });

  final int? category;
  final String? language;
  final String? level;
  final num? priceMin;
  final num? priceMax;
  final String? search;
  final String? ordering;

  bool get hasActiveFilters =>
      category != null ||
      language != null ||
      level != null ||
      priceMin != null ||
      priceMax != null;

  CatalogFilters copyWith({
    int? category,
    bool clearCategory = false,
    String? language,
    bool clearLanguage = false,
    String? level,
    bool clearLevel = false,
    num? priceMin,
    num? priceMax,
    bool clearPrice = false,
    String? search,
    String? ordering,
  }) {
    return CatalogFilters(
      category: clearCategory ? null : (category ?? this.category),
      language: clearLanguage ? null : (language ?? this.language),
      level: clearLevel ? null : (level ?? this.level),
      priceMin: clearPrice ? null : (priceMin ?? this.priceMin),
      priceMax: clearPrice ? null : (priceMax ?? this.priceMax),
      search: search ?? this.search,
      ordering: ordering ?? this.ordering,
    );
  }

  @override
  List<Object?> get props => [
    category,
    language,
    level,
    priceMin,
    priceMax,
    search,
    ordering,
  ];
}

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this._repository) : super(const CatalogInitial());

  static const int _pageSize = 10;

  final CatalogRepository _repository;
  CatalogFilters _filters = const CatalogFilters();
  int _page = 1;

  CatalogFilters get filters => _filters;

  /// Full (re)load of the first page with [filters]. Categories are fetched
  /// alongside the courses the first time and cached in the success state.
  Future<void> load({CatalogFilters filters = const CatalogFilters()}) async {
    _filters = filters;
    _page = 1;
    emit(const CatalogLoading());

    final categories = await _loadCategories();

    try {
      final page = await _repository.getCourses(
        category: filters.category,
        language: filters.language,
        level: filters.level,
        priceMin: filters.priceMin,
        priceMax: filters.priceMax,
        search: filters.search,
        ordering: filters.ordering,
        page: 1,
        pageSize: _pageSize,
      );
      emit(
        CatalogSuccess(
          courses: page.results,
          categories: categories,
          totalCount: page.count,
          hasMore: page.next != null,
          filters: filters,
        ),
      );
    } on NetworkException catch (error) {
      emit(CatalogFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const CatalogFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> applyFilters(CatalogFilters filters) => load(filters: filters);

  Future<void> refresh() => load(filters: _filters);

  /// Appends the next page without dropping the currently visible courses.
  Future<void> loadMore() async {
    final current = state;
    if (current is! CatalogSuccess ||
        current.isLoadingMore ||
        !current.hasMore) {
      return;
    }

    emit(current.copyWith(isLoadingMore: true));
    try {
      final page = await _repository.getCourses(
        category: _filters.category,
        language: _filters.language,
        level: _filters.level,
        priceMin: _filters.priceMin,
        priceMax: _filters.priceMax,
        search: _filters.search,
        ordering: _filters.ordering,
        page: _page + 1,
        pageSize: _pageSize,
      );
      _page += 1;
      emit(
        current.copyWith(
          courses: [...current.courses, ...page.results],
          totalCount: page.count,
          hasMore: page.next != null,
          isLoadingMore: false,
        ),
      );
    } on NetworkException catch (error) {
      emit(current.copyWith(isLoadingMore: false, loadMoreError: error.message));
    }
  }

  Future<List<CategoryDto>> _loadCategories() async {
    try {
      return await _repository.getCategories();
    } on NetworkException {
      return const [];
    }
  }
}
