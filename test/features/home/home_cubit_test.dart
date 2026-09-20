import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';
import 'package:coach_space/features/student/home/data/models/category.dart';
import 'package:coach_space/features/student/home/data/models/home_data.dart';
import 'package:coach_space/features/student/home/data/repo/home_repository.dart';
import 'package:coach_space/features/student/home/logic/cubit/home_cubit.dart';
import 'package:coach_space/features/student/home/logic/cubit/home_state.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';

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

EnrollmentDto _enrollment({int courseId = 1, bool isCompleted = false}) =>
    EnrollmentDto(
      id: 11,
      course: EnrollmentCourseDto(
        id: courseId,
        title: 'Course $courseId',
        coverImage: '',
        instructor: const InstructorSummaryDto(
          id: 9,
          fullName: 'Coach',
          avatar: '',
        ),
        status: 'published',
      ),
      progressPercent: 40,
      isCompleted: isCompleted,
      enrolledAt: DateTime(2026, 1, 2),
    );

class _FakeHomeRepository implements HomeRepository {
  HomeData? homeData;
  Object? error;
  int homeDataCalls = 0;

  @override
  Future<List<Category>> getCategories() async =>
      homeData?.categories ?? const [];

  @override
  Future<HomeData> getHomeData() async {
    homeDataCalls++;
    if (error != null) throw error!;
    return homeData!;
  }
}

void main() {
  late _FakeHomeRepository repository;
  late HomeCubit cubit;

  setUp(() {
    repository = _FakeHomeRepository();
    cubit = HomeCubit(repository: repository);
  });

  tearDown(() => cubit.close());

  group('HomeCubit', () {
    test('starts in HomeInitial', () {
      expect(cubit.state, isA<HomeInitial>());
    });

    test('emits Loading then Success with the repository payload', () async {
      repository.homeData = HomeData(
        categories: const [Category(id: '1', name: 'Development')],
        recommendedCourses: [_course(1), _course(2)],
        continueEnrollment: _enrollment(),
      );
      final emissions = <HomeState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.loadHome();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [isA<HomeLoading>(), isA<HomeSuccess>()]);
      final data = (cubit.state as HomeSuccess).data;
      expect(data.categories, hasLength(1));
      expect(data.recommendedCourses.map((course) => course.id), [1, 2]);
      expect(data.continueEnrollment?.id, 11);

      await subscription.cancel();
    });

    test('emits HomeEmpty when both collections are empty', () async {
      repository.homeData = const HomeData(
        categories: [],
        recommendedCourses: [],
      );

      await cubit.loadHome();

      expect(cubit.state, isA<HomeEmpty>());
    });

    test('emits HomeOffline for an offline NetworkException', () async {
      repository.error = const NetworkException(
        kind: FailureKind.offline,
        message: 'تعذر الاتصال بالخادم، تحقق من اتصالك بالإنترنت',
      );

      await cubit.loadHome();

      expect(cubit.state, isA<HomeOffline>());
    });

    test('emits HomeError with the message for other failures', () async {
      repository.error = const NetworkException(
        kind: FailureKind.serverError,
        message: 'Server exploded',
      );

      await cubit.loadHome();

      expect(cubit.state, isA<HomeError>());
      expect((cubit.state as HomeError).message, 'Server exploded');
    });
  });
}
