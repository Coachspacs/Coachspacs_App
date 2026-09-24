import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_verify_dto.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository.dart';
import 'package:coach_space/features/student/profile/logic/cubit/certificates_cubit.dart';

CertificateDto _certificate(int id) => CertificateDto(
  id: id,
  certificateCode: 'CERT-$id',
  pdfUrl: '/api/certificates/$id/pdf',
  issuedAt: DateTime(2026, 2, 1),
);

class _FakeCertificateRepository implements CertificateRepository {
  PaginatedResponse<CertificateDto> page = const PaginatedResponse(
    count: 0,
    results: [],
  );
  Object? listError;
  List<int>? bytes;
  Object? downloadError;
  final List<int> downloadedIds = [];

  @override
  Future<PaginatedResponse<CertificateDto>> getCertificates({
    int page = 1,
    int pageSize = 20,
  }) async {
    if (listError != null) throw listError!;
    return this.page;
  }

  @override
  Future<List<int>> downloadCertificate(int id) async {
    downloadedIds.add(id);
    if (downloadError != null) throw downloadError!;
    return bytes ?? const [];
  }

  @override
  Future<CertificateVerifyDto> verifyCertificate(String code) async =>
      throw UnimplementedError();
}

void main() {
  late _FakeCertificateRepository repository;
  late CertificatesCubit cubit;

  setUp(() {
    repository = _FakeCertificateRepository();
    cubit = CertificatesCubit(repository);
  });

  tearDown(() => cubit.close());

  group('CertificatesCubit.load', () {
    test('emits Loading then Success with the certificates', () async {
      repository.page = PaginatedResponse(
        count: 2,
        results: [_certificate(1), _certificate(2)],
      );
      final emissions = <CertificatesState>[];
      final subscription = cubit.stream.listen(emissions.add);

      await cubit.load();
      await Future<void>.delayed(Duration.zero);

      expect(emissions, [
        isA<CertificatesLoading>(),
        isA<CertificatesSuccess>(),
      ]);
      expect(
        (cubit.state as CertificatesSuccess).certificates,
        hasLength(2),
      );

      await subscription.cancel();
    });

    test('emits CertificatesEmpty when there are none', () async {
      await cubit.load();

      expect(cubit.state, isA<CertificatesEmpty>());
    });

    test('emits CertificatesFailure with kind and message on error', () async {
      repository.listError = const NetworkException(
        kind: FailureKind.serverError,
        message: 'Certificates unavailable',
      );

      await cubit.load();

      expect(cubit.state, isA<CertificatesFailure>());
      final failure = cubit.state as CertificatesFailure;
      expect(failure.kind, FailureKind.serverError);
      expect(failure.message, 'Certificates unavailable');
    });
  });

  group('CertificatesCubit.download', () {
    test('caches the downloaded bytes', () async {
      repository.bytes = const [37, 80, 68, 70];

      final result = await cubit.download(3);

      expect(result, isTrue);
      expect(repository.downloadedIds, [3]);
      expect(cubit.bytesFor(3), const [37, 80, 68, 70]);
      expect(cubit.bytesFor(4), isNull);
    });

    test('returns false when the download fails', () async {
      repository.downloadError = const NetworkException(
        kind: FailureKind.notFound,
        message: 'Not found',
      );

      expect(await cubit.download(3), isFalse);
      expect(cubit.bytesFor(3), isNull);
    });
  });
}
