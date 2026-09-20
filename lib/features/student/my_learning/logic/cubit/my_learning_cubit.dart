import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/my_learning/data/models/enrollment_dto.dart';
import 'package:coach_space/features/student/my_learning/data/repo/enrollment_repository.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository.dart';

part 'my_learning_state.dart';

/// Loads the student's enrollments and (best-effort) earned certificates.
class MyLearningCubit extends Cubit<MyLearningState> {
  MyLearningCubit({
    required EnrollmentRepository enrollmentRepository,
    required CertificateRepository certificateRepository,
  }) : _enrollmentRepository = enrollmentRepository,
       _certificateRepository = certificateRepository,
       super(const MyLearningInitial());

  final EnrollmentRepository _enrollmentRepository;
  final CertificateRepository _certificateRepository;

  Future<void> load() async {
    emit(const MyLearningLoading());
    try {
      final page = await _enrollmentRepository.getEnrollments(pageSize: 50);
      final certificates = await _loadCertificates();
      final enrollments = page.results;

      if (enrollments.isEmpty) {
        emit(MyLearningEmpty(certificates: certificates));
      } else {
        emit(
          MyLearningSuccess(
            enrollments: enrollments,
            certificates: certificates,
          ),
        );
      }
    } on NetworkException catch (error) {
      emit(MyLearningFailure(kind: error.kind, message: error.message));
    } catch (_) {
      emit(
        const MyLearningFailure(
          kind: FailureKind.unknown,
          message: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> refresh() => load();

  Future<List<CertificateDto>> _loadCertificates() async {
    try {
      final page = await _certificateRepository.getCertificates(pageSize: 20);
      return page.results;
    } on NetworkException {
      return const [];
    }
  }
}
