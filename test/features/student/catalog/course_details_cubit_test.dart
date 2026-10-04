import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';
import 'package:coach_space/features/student/catalog/data/models/category_dto.dart';
import 'package:coach_space/features/student/catalog/data/repo/catalog_repository.dart';
import 'package:coach_space/features/student/catalog/logic/cubit/course_details_cubit.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/data/models/lesson_summary_dto.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';
import 'package:coach_space/features/student/profile/data/models/cart_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/cart_repository.dart';

CourseDetailDto _courseDetail(int id) => CourseDetailDto(
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
  status: 'published',
  createdAt: DateTime(2026, 1, 1),
  sections: const [],
  totalLessons: 8,
  totalDurationMinutes: 90,
  isEnrolled: false,
);

EnrollmentDto _enrollment({required int id, required int courseId}) =>
    EnrollmentDto(
      id: id,
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
      progressPercent: 25,
      isCompleted: false,
      enrolledAt: DateTime(2026, 1, 2),
    );

class _FakeCatalogRepository implements CatalogRepository {
  CourseDetailDto? course;
  Object? error;
  final List<int> requestedIds = [];

  @override
  Future<List<CategoryDto>> getCategories() async => const [];

  @override
  Future<PaginatedResponse<CatalogCourseDto>> getCourses({
    int? category,
    String? language,
    String? level,
    num? priceMin,
    num? priceMax,
    String? search,
    String? ordering,
    int? page,
    int? pageSize,
  }) async => throw UnimplementedError();

  @override
  Future<CourseDetailDto> getCourse(int id) async {
    requestedIds.add(id);
    if (error != null) throw error!;
    return course!;
  }

  @override
  Future<List<int>> downloadAttachment(int id) async =>
      throw UnimplementedError();
}

class _FakeEnrollmentRepository implements EnrollmentRepository {
  PaginatedResponse<EnrollmentDto> page = const PaginatedResponse(
    count: 0,
    results: [],
  );
  Object? error;
  int calls = 0;

  @override
  Future<PaginatedResponse<EnrollmentDto>> getEnrollments({
    int page = 1,
    int pageSize = 20,
  }) async {
    calls++;
    if (error != null) throw error!;
    return this.page;
  }

  @override
  Future<LessonPlayerDto> getLesson(int enrollmentId, int lessonId) async =>
      throw UnimplementedError();

  @override
  Future<void> enrollFree(int courseId) async {}

  @override
  Future<void> markLessonComplete(int enrollmentId, int lessonId) async {}

  @override
  Future<void> markLessonIncomplete(int enrollmentId, int lessonId) async {}

  @override
  Future<LessonSummaryDto> getLessonSummary(int lessonId) async =>
      throw UnimplementedError();
}
class _FakeCartRepository implements CartRepository {
  Object? addError;
  final List<int> addedCourseIds = [];
  final List<int> removedItemIds = [];

  @override
  Future<CartDto> getCart() async => throw UnimplementedError();

  @override
  Future<void> addItem(int courseId) async {
    addedCourseIds.add(courseId);
    if (addError != null) throw addError!;
  }

  @override
  Future<void> removeItem(int itemId) async => removedItemIds.add(itemId);
}

void main() {
  late _FakeCatalogRepository catalogRepository;
  late _FakeEnrollmentRepository enrollmentRepository;
  late _FakeCartRepository cartRepository;
  late CourseDetailsCubit cubit;

  setUp(() {
    catalogRepository = _FakeCatalogRepository();
    enrollmentRepository = _FakeEnrollmentRepository();
    cartRepository = _FakeCartRepository();
    cubit = CourseDetailsCubit(
      catalogRepository: catalogRepository,
      enrollmentRepository: enrollmentRepository,
      cartRepository: cartRepository,
    );
  });

  tearDown(() => cubit.close());

  group('CourseDetailsCubit.load', () {
    test('sets the course and its matching enrollment', () async {
      catalogRepository.course = _courseDetail(7);
      enrollmentRepository.page = PaginatedResponse(
        count: 1,
        results: [_enrollment(id: 21, courseId: 7)],
      );

      await cubit.load(7);

      expect(catalogRepository.requestedIds, [7]);
      expect(cubit.state, isA<CourseDetailsSuccess>());
      final state = cubit.state as CourseDetailsSuccess;
      expect(state.course.id, 7);
      expect(state.enrollment?.id, 21);
      expect(state.isEnrolled, isTrue);
    });

    test('succeeds without an enrollment when none matches', () async {
      catalogRepository.course = _courseDetail(7);
      enrollmentRepository.page = PaginatedResponse(
        count: 1,
        results: [_enrollment(id: 21, courseId: 99)],
      );

      await cubit.load(7);

      final state = cubit.state as CourseDetailsSuccess;
      expect(state.enrollment, isNull);
      expect(state.isEnrolled, isFalse);
    });

    test('still succeeds when the enrollment lookup fails', () async {
      catalogRepository.course = _courseDetail(7);
      enrollmentRepository.error = const NetworkException(
        kind: FailureKind.offline,
        message: 'offline',
      );

      await cubit.load(7);

      expect(cubit.state, isA<CourseDetailsSuccess>());
      expect((cubit.state as CourseDetailsSuccess).enrollment, isNull);
    });

    test('emits CourseDetailsFailure when the course request fails', () async {
      catalogRepository.error = const NetworkException(
        kind: FailureKind.notFound,
        message: 'Course not found',
      );

      await cubit.load(7);

      expect(cubit.state, isA<CourseDetailsFailure>());
      final failure = cubit.state as CourseDetailsFailure;
      expect(failure.kind, FailureKind.notFound);
      expect(failure.message, 'Course not found');
    });
  });

  group('CourseDetailsCubit.addToCart', () {
    test('adds the course and returns true', () async {
      catalogRepository.course = _courseDetail(7);
      await cubit.load(7);

      final result = await cubit.addToCart();

      expect(result, isTrue);
      expect(cartRepository.addedCourseIds, [7]);
      final state = cubit.state as CourseDetailsSuccess;
      expect(state.isAddingToCart, isFalse);
    });

    test('returns false and clears isAddingToCart on failure', () async {
      catalogRepository.course = _courseDetail(7);
      cartRepository.addError = const NetworkException(
        kind: FailureKind.conflict,
        message: 'Already in cart',
      );
      await cubit.load(7);
      final emissions = <CourseDetailsState>[];
      final subscription = cubit.stream.listen(emissions.add);

      final result = await cubit.addToCart();
      await Future<void>.delayed(Duration.zero);

      expect(result, isFalse);
      final state = cubit.state as CourseDetailsSuccess;
      expect(state.isAddingToCart, isFalse);
      expect(emissions, hasLength(2));
      expect(
        (emissions.first as CourseDetailsSuccess).isAddingToCart,
        isTrue,
      );
      expect((emissions.last as CourseDetailsSuccess).isAddingToCart, isFalse);

      await subscription.cancel();
    });
  });
}
