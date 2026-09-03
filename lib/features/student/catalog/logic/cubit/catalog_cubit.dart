import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/data/repo/catalog_repository.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this._repository) : super(const CatalogInitial());

  final CatalogRepository _repository;

  Future<void> load({
    int? category,
    String? language,
    String? level,
    num? priceMin,
    num? priceMax,
    String? search,
  }) async {
    emit(const CatalogLoading());
    try {
      final page = await _repository.getCourses(
        category: category,
        language: language,
        level: level,
        priceMin: priceMin,
        priceMax: priceMax,
        search: search,
        page: 1,
        pageSize: 50,
      );
      emit(CatalogSuccess(page));
    } on NetworkException catch (error) {
      emit(CatalogFailure(error.message));
    } catch (_) {
      emit(const CatalogFailure('Unable to load courses. Please try again.'));
    }
  }
}
