import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';
import 'package:coach_space/features/student/my_learning/logic/cubit/my_learning_cubit.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_verify_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository.dart';
import 'package:coach_space/features/student/catalog/data/models/catalog_course_dto.dart';

EnrollmentDto _enrollment(int id) => EnrollmentDto(
  id: id,
  course: EnrollmentCourseDto(
    id: id,
    title: 'Course $id',
    coverImage: '',
    instructor: const InstructorSummaryDto(id: 9, fullName: 'Coach', avatar: ''),
    status: 'published',
  ),
  progressPercent: 30,
  isCompleted: false,
  enrolledAt: DateTime(2026, 1, 2),
);

CertificateDto _certificate(int id) => CertificateDto(
  id: id,
  certificateCode: 'CERT-$id',
  pdfUrl: '/api/certificates/$id/pdf',
  issuedAt: DateTime(2026, 2, 1),
);

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
}

class _FakeCertificateRepository implements CertificateRepository {
  PaginatedResponse<CertificateDto> page = const PaginatedResponse(
    count: 0,
    results: [],
  );
  Object? error;

  @override
  Future<PaginatedResponse<CertificateDto>> getCertificates({
    int page = 1,
    int pageSize = 20,
  }) async {
    if (error != null) throw error!;
    return this.page;
  }

  @override
  Future<List<int>> downloadCertificate(int id) async => const [];

  @override
  Future<CertificateVerifyDto> verifyCertificate(String code) async =>
      throw UnimplementedError();
}

void main() {
  late _FakeEnrollmentRepository enrollmentRepository;
  late _FakeCertificateRepository certificateRepository;
  late MyLearningCubit cubit;

  setUp(() {
    enrollmentRepository = _FakeEnrollmentRepository();
    certificateRepository = _FakeCertificateRepository();
    cubit = MyLearningCubit(
      enrollmentRepository: enrollmentRepository,
      certificateRepository: certificateRepository,
    );
  });

  tearDown(() => cubit.close());

  test('load emits Loading then Success with enrollments and certificates', () async {
    enrollmentRepository.page = PaginatedResponse(
      count: 2,
      results: [_enrollment(1), _enrollment(2)],
    );
    certificateRepository.page = PaginatedResponse(
      count: 1,
      results: [_certificate(5)],
    );
    final emissions = <MyLearningState>[];
    final subscription = cubit.stream.listen(emissions.add);

    await cubit.load();
    await Future<void>.delayed(Duration.zero);

    expect(emissions, [isA<MyLearningLoading>(), isA<MyLearningSuccess>()]);
    final state = cubit.state as MyLearningSuccess;
    expect(state.enrollments.map((e) => e.id), [1, 2]);
    expect(state.certificates.map((c) => c.id), [5]);

    await subscription.cancel();
  });

  test('load emits MyLearningEmpty when there are no enrollments', () async {
    certificateRepository.page = PaginatedResponse(
      count: 1,
      results: [_certificate(5)],
    );

    await cubit.load();

    expect(cubit.state, isA<MyLearningEmpty>());
    expect((cubit.state as MyLearningEmpty).certificates, hasLength(1));
  });

  test('load emits MyLearningFailure with kind and message', () async {
    enrollmentRepository.error = const NetworkException(
      kind: FailureKind.unauthorized,
      message: 'Session expired',
    );

    await cubit.load();

    expect(cubit.state, isA<MyLearningFailure>());
    final failure = cubit.state as MyLearningFailure;
    expect(failure.kind, FailureKind.unauthorized);
    expect(failure.message, 'Session expired');
  });

  test('swallows certificate failures and keeps the enrollments', () async {
    enrollmentRepository.page = PaginatedResponse(
      count: 1,
      results: [_enrollment(1)],
    );
    certificateRepository.error = const NetworkException(
      kind: FailureKind.serverError,
      message: 'boom',
    );

    await cubit.load();

    expect(cubit.state, isA<MyLearningSuccess>());
    final state = cubit.state as MyLearningSuccess;
    expect(state.enrollments, hasLength(1));
    expect(state.certificates, isEmpty);
  });
}
