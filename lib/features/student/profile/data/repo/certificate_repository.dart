import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_detail_dto.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_verify_dto.dart';

/// Contract for `GET /api/certificates` endpoints.
abstract class CertificateRepository {
  Future<PaginatedResponse<CertificateDto>> getCertificates({
    int page = 1,
    int pageSize = 20,
  });

  /// Everything needed to render one certificate locally — the backend never
  /// generates a certificate image/PDF itself (US-16 scenario 2).
  Future<CertificateDetailDto> getCertificate(int id);

  /// Public, unauthenticated lookup of a certificate by its code (US-18).
  /// Throws a [NetworkException] with [FailureKind.notFound] for a validly
  /// shaped but unrecognised code and [FailureKind.validation] for a
  /// malformed one.
  Future<CertificateVerifyDto> verifyCertificate(String code);
}
