import 'package:dio/dio.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/core/networking/paginated_response.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_dto.dart';
import 'package:coach_space/features/student/profile/data/models/certificate_verify_dto.dart';

import 'certificate_repository.dart';

class CertificateRepositoryImpl implements CertificateRepository {
  CertificateRepositoryImpl({required ApiService apiService})
    : _api = apiService;

  final ApiService _api;

  @override
  Future<PaginatedResponse<CertificateDto>> getCertificates({
    int page = 1,
    int pageSize = 20,
  }) => _guard(() => _api.getCertificates(page: page, pageSize: pageSize));

  @override
  Future<List<int>> downloadCertificate(int id) =>
      _guard(() => _api.downloadCertificate(id));

  @override
  Future<CertificateVerifyDto> verifyCertificate(String code) =>
      _guard(() => _api.verifyCertificate(code));

  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      throw NetworkException.fromDioException(error);
    }
  }
}
