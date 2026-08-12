import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/features/home/data/models/mock_home_data.dart';
import 'package:coach_space/features/home/logic/cubit/home_state.dart';

/// Orchestrates the home screen.
///
/// Currently renders purely from local static mock data ([MockHomeData]) —
/// no backend API, repository, or HTTP client is involved. When the API
/// lands, `loadHome` will instead delegate to the data layer, keeping the
/// [HomeState] contract (Loading / Success / Empty / Error / Offline).
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  Future<void> loadHome() async {
    emit(const HomeLoading());
    emit(HomeSuccess(data: MockHomeData.aggregate));
  }
}
