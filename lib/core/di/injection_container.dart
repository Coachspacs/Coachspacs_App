import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:coach_space/core/networking/api_client.dart';
import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/storage/session_storage.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository.dart';
import 'package:coach_space/features/auth/data/repo/auth_repository_impl.dart';
import 'package:coach_space/features/auth/logic/cubit/auth_cubit.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository.dart';
import 'package:coach_space/features/instructor/courses/data/repo/instructor_courses_repository_impl.dart';
import 'package:coach_space/features/instructor/dashboard/data/repo/instructor_dashboard_repository.dart';
import 'package:coach_space/features/instructor/dashboard/data/repo/instructor_dashboard_repository_impl.dart';
import 'package:coach_space/features/instructor/dashboard/logic/cubit/instructor_dashboard_cubit.dart';
import 'package:coach_space/features/instructor/students/data/repo/instructor_students_repository.dart';
import 'package:coach_space/features/instructor/students/data/repo/instructor_students_repository_impl.dart';
import 'package:coach_space/features/instructor/students/logic/cubit/instructor_students_cubit.dart';
import 'package:coach_space/features/student/catalog/data/repo/catalog_repository.dart';
import 'package:coach_space/features/student/catalog/data/repo/catalog_repository_impl.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/catalog_cubit.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/course_details_cubit.dart';
import 'package:coach_space/features/student/home/data/repo/home_repository.dart';
import 'package:coach_space/features/student/home/data/repo/home_repository_impl.dart';
import 'package:coach_space/features/student/home/logic/cubit/home_cubit.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository_impl.dart';
import 'package:coach_space/features/student/my_learning/logic/cubit/my_learning_cubit.dart';
import 'package:coach_space/features/student/my_learning/logic/cubit/lesson_player_cubit.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository_impl.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository_impl.dart';
import 'package:coach_space/features/student/profile/data/repo/order_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/order_repository_impl.dart';
import 'package:coach_space/features/student/profile/data/repo/profile_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/profile_repository_impl.dart';
import 'package:coach_space/features/student/profile/logic/cubit/browse_courses_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/cart_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/certificates_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/checkout_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/dashboard_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/order_history_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/profile_cubit.dart';
import 'package:coach_space/features/student/profile/logic/cubit/security_cubit.dart';

/// Application composition root.
///
/// Registers feature state managers, repositories, and infrastructure. Feature
/// code must never instantiate dependencies directly; resolve them through
/// [getIt] (or receive them via constructor injection).
final GetIt getIt = GetIt.instance;

void setupLocator() {
  // =========================================================
  // INFRASTRUCTURE
  // =========================================================

  getIt.registerLazySingleton<SessionStorage>(SessionStorage.new);
  getIt.registerLazySingleton<Dio>(
    () => ApiClient.create(sessionStorage: getIt<SessionStorage>()),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  // =========================================================
  // REPOSITORIES
  // =========================================================

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiService: getIt<ApiService>(),
      sessionStorage: getIt<SessionStorage>(),
    ),
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
  getIt.registerLazySingleton<InstructorDashboardRepository>(
    () => InstructorDashboardRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<InstructorStudentsRepository>(
    () => InstructorStudentsRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CatalogRepository>(
    () => CatalogRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<EnrollmentRepository>(
    () => EnrollmentRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<CertificateRepository>(
    () => CertificateRepositoryImpl(apiService: getIt<ApiService>()),
  );

  // =========================================================
  // CUBITS
  // =========================================================

  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(repository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(repository: getIt<HomeRepository>()),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(repository: getIt<ProfileRepository>()),
  );
  getIt.registerFactory<CatalogCubit>(
    () => CatalogCubit(getIt<CatalogRepository>()),
  );
  getIt.registerFactory<CourseDetailsCubit>(
    () => CourseDetailsCubit(
      catalogRepository: getIt<CatalogRepository>(),
      enrollmentRepository: getIt<EnrollmentRepository>(),
      cartRepository: getIt<CartRepository>(),
    ),
  );
  getIt.registerFactory<MyLearningCubit>(
    () => MyLearningCubit(
      enrollmentRepository: getIt<EnrollmentRepository>(),
      certificateRepository: getIt<CertificateRepository>(),
    ),
  );
  getIt.registerFactory<LessonPlayerCubit>(
    () => LessonPlayerCubit(enrollmentRepository: getIt<EnrollmentRepository>()),
  );
  getIt.registerFactory<InstructorDashboardCubit>(
    () => InstructorDashboardCubit(
      dashboardRepository: getIt<InstructorDashboardRepository>(),
      coursesRepository: getIt<InstructorCoursesRepository>(),
    ),
  );
  getIt.registerFactory<InstructorStudentsCubit>(
    () => InstructorStudentsCubit(
      studentsRepository: getIt<InstructorStudentsRepository>(),
      coursesRepository: getIt<InstructorCoursesRepository>(),
    ),
  );
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(
      enrollmentRepository: getIt<EnrollmentRepository>(),
      profileRepository: getIt<ProfileRepository>(),
    ),
  );
  getIt.registerFactory<BrowseCoursesCubit>(
    () => BrowseCoursesCubit(getIt<EnrollmentRepository>()),
  );
  getIt.registerFactory<SecurityCubit>(
    () => SecurityCubit(getIt<AuthRepository>()),
  );
  getIt.registerFactory<CartCubit>(
    () => CartCubit(getIt<CartRepository>()),
  );
  getIt.registerFactory<CheckoutCubit>(
    () => CheckoutCubit(
      cartRepository: getIt<CartRepository>(),
      orderRepository: getIt<OrderRepository>(),
    ),
  );
  getIt.registerFactory<OrderHistoryCubit>(
    () => OrderHistoryCubit(getIt<OrderRepository>()),
  );
  getIt.registerFactory<CertificatesCubit>(
    () => CertificatesCubit(getIt<CertificateRepository>()),
  );
}
