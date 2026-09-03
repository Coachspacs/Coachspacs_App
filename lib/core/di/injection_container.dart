import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:coach_space/core/networking/api_client.dart';
import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/storage/session_storage.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository_impl.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/student/home/data/repo/home_repository.dart';
import 'package:coach_space/features/student/home/data/repo/home_repository_impl.dart';
import 'package:coach_space/features/student/home/logic/cubit/home_cubit.dart';
import 'package:coach_space/features/student/profile/data/repo/profile_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/profile_repository_impl.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_cubit.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository_impl.dart';

/// Application composition root.
///
/// Registers feature state managers, repositories, and infrastructure. Feature
/// code must never instantiate dependencies directly; resolve them through
/// [getIt] (or receive them via constructor injection).
final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<SessionStorage>(SessionStorage.new);
  getIt.registerLazySingleton<Dio>(
    () => ApiClient.create(sessionStorage: getIt<SessionStorage>()),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiService: getIt<ApiService>(),
      sessionStorage: getIt<SessionStorage>(),
    ),
  );
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(repository: getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<InstructorCoursesRepository>(
    () => InstructorCoursesRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(repository: getIt<HomeRepository>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(repository: getIt<ProfileRepository>()),
  );
}
