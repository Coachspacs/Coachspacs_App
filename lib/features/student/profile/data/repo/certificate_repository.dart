import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_verify_dto.dart';

/// Contract for `GET /api/certificates` endpoints.
abstract class CertificateRepository {
  Future<PaginatedResponse<CertificateDto>> getCertificates({
    int page = 1,
    int pageSize = 20,
  });

  /// Raw PDF bytes of the certificate.
  Future<List<int>> downloadCertificate(int id);

  /// Public, unauthenticated lookup of a certificate by its code (US-18).
  /// Throws a [NetworkException] with [FailureKind.notFound] for a validly
  /// shaped but unrecognised code and [FailureKind.validation] for a
  /// malformed one.
  Future<CertificateVerifyDto> verifyCertificate(String code);
}
