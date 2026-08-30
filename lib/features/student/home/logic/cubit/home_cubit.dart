// ignore_for_file: prefer_initializing_formals

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';

import '../../data/repo/home_repository.dart';
import 'home_state.dart';

/// Orchestrates the home screen.
///
/// Categories are fetched from `GET /api/catalog/categories` via
/// [HomeRepository]; featured/trending courses remain local mock data until
/// the backend exposes course endpoints (none exist on the current backend).
class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required HomeRepository repository})
      : _repository = repository,
        super(const HomeInitial());

  final HomeRepository _repository;

  Future<void> loadHome() async {
    emit(const HomeLoading());
    try {
      final data = await _repository.getHomeData();
      if (data.isEmpty) {
        emit(const HomeEmpty());
      } else {
        emit(HomeSuccess(data: data));
      }
    } on NetworkException catch (error) {
      if (error.kind == FailureKind.offline) {
        emit(const HomeOffline());
      } else {
        emit(HomeError(message: error.message));
      }
    } catch (_) {
      emit(const HomeError());
    }
  }
}
