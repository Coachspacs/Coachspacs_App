import 'package:get_it/get_it.dart';

import 'package:coach_space/features/home/logic/cubit/home_cubit.dart';

/// Application composition root.
///
/// Registers feature state managers and (once the backend lands) repositories.
/// Feature code must never instantiate dependencies directly; resolve them
/// through [getIt] (or receive them via constructor injection).
final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerFactory<HomeCubit>(HomeCubit.new);
}
