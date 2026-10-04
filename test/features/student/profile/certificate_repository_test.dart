import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coach_space/core/networking/api_service.dart';
import 'package:coach_space/core/networking/network_exceptions.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository.dart';
import 'package:coach_space/features/student/profile/data/repo/certificate_repository_impl.dart';

class _MockAdapter implements HttpClientAdapter {
  _MockAdapter(this._handler);

  final Future<ResponseBody> Function(
    RequestOptions options,
    List<RequestOptions> all,
  )
  _handler;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return _handler(options, requests);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(Object data, int status) => ResponseBody.fromString(
  jsonEncode(data),
  status,
  headers: {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  },
);

CertificateRepository _repositoryWith(_MockAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test.local/'));
  dio.httpClientAdapter = adapter;
  return CertificateRepositoryImpl(apiService: ApiService(dio));
}

const _certificateJson = {
  'id': 3,
  'certificate_code': 'CERT-3',
  'pdf_url': '/api/certificates/3/pdf',
  'issued_at': '2026-02-01T00:00:00.000Z',
};

void main() {
  group('CertificateRepositoryImpl.getCertificates', () {
    test('GETs api/certificates with pagination and parses the page', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'GET');
        expect(options.path, 'api/certificates');
        expect(options.queryParameters, {'page': 1, 'page_size': 20});
        return _json({
          'count': 1,
          'next': null,
          'previous': null,
          'results': [_certificateJson],
        }, 200);
      });

      final page = await _repositoryWith(adapter).getCertificates();

      expect(page.count, 1);
      expect(page.results.single.id, 3);
      expect(page.results.single.certificateCode, 'CERT-3');
    });
  });

  group('CertificateRepositoryImpl.getCertificate', () {
    test('GETs the detail path and parses the certificate', () async {
      final adapter = _MockAdapter((options, all) async {
        expect(options.method, 'GET');
        expect(options.path, 'api/certificates/7');
        return _json({
          'id': 7,
          'certificate_code': 'CERT-7',
          'student_full_name': 'Ahmad Ali',
          'course_title': 'Flutter Basics',
          'instructor_full_name': 'Sara Hassan',
          'issued_at': '2026-02-01T10:00:00Z',
        }, 200);
      });

      final certificate = await _repositoryWith(adapter).getCertificate(7);

      expect(certificate.id, 7);
      expect(certificate.certificateCode, 'CERT-7');
      expect(certificate.studentFullName, 'Ahmad Ali');
      expect(certificate.courseTitle, 'Flutter Basics');
      expect(certificate.instructorFullName, 'Sara Hassan');
      expect(adapter.requests, hasLength(1));
    });

    test('maps a 404 to NetworkException.notFound', () async {
      final adapter = _MockAdapter(
        (options, all) async => _json({'detail': 'Not found.'}, 404),
      );

      expect(
        () => _repositoryWith(adapter).getCertificate(7),
        throwsA(
          isA<NetworkException>().having(
            (error) => error.kind,
            'kind',
            FailureKind.notFound,
          ),
        ),
      );
    });
  });
}
