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
  const CatalogSuccess(this.page);
  final PaginatedResponse<CatalogCourseDto> page;
}

final class CatalogFailure extends CatalogState {
  const CatalogFailure(this.message);
  final String message;
}
