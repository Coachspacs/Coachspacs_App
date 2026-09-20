part of 'catalog_cubit.dart';

sealed class CatalogState {
  const CatalogState();
}

final class CatalogInitial extends CatalogState {
  const CatalogInitial();
}

final class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

final class CatalogSuccess extends CatalogState {
  const CatalogSuccess({
    required this.courses,
    required this.categories,
    required this.totalCount,
    required this.hasMore,
    required this.filters,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<CatalogCourseDto> courses;
  final List<CategoryDto> categories;
  final int totalCount;
  final bool hasMore;
  final CatalogFilters filters;
  final bool isLoadingMore;
  final String? loadMoreError;

  bool get isEmpty => courses.isEmpty;

  CatalogSuccess copyWith({
    List<CatalogCourseDto>? courses,
    List<CategoryDto>? categories,
    int? totalCount,
    bool? hasMore,
    CatalogFilters? filters,
    bool? isLoadingMore,
    String? loadMoreError,
  }) => CatalogSuccess(
    courses: courses ?? this.courses,
    categories: categories ?? this.categories,
    totalCount: totalCount ?? this.totalCount,
    hasMore: hasMore ?? this.hasMore,
    filters: filters ?? this.filters,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    loadMoreError: loadMoreError,
  );
}

final class CatalogFailure extends CatalogState {
  const CatalogFailure({required this.kind, required this.message});

  final FailureKind kind;
  final String message;
}
